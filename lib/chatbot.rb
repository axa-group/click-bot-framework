module Chatbot
  def self.handle_response(response, platform)

    if response.blank? || !response.key?(:object) || !response.key?(:entry)
      return
    end

    if response[:object] == "page"
      response[:entry].each do |entry|

        entry[:messaging].each do |messaging_event|

          # the facebook ID of the person sending you the message
          sender_id = messaging_event["sender"]["id"]        
          
          # find or initialize user session
          session = UserSession.find_or_create_by(platform: platform, facebook_user_id: sender_id)
          
          # user sent a message 
          if messaging_event.key?("message") && messaging_event["message"].key?("text")
            CustomLogger.log("Message received", namespace: "Messenger") do |logger|
              logger.add(messaging_event["message"]["text"])
              handle_text_message(messaging_event["message"]["text"], session)
            end

          # user clicked a button
          elsif messaging_event.key?("postback")

            # in off topic context
            if (off_topic = session.off_topic).present?
              session.update_attributes(off_topic: nil)
              if messaging_event["postback"]["payload"] == "yes"
                off_topic.perform!(session)
              else
                # repeat former question
                handle_node(session.node_id, session)
              end
            
            #regular tree node
            else
              handle_node(messaging_event["postback"]["payload"], session)
            end
          end
        end
      end
    end
  end

  private

  def self.handle_text_message(message_text, session)

    platform = session.platform

    # assign last node id or identify root node
    parent_id = session.node_id || platform.tree.root_node_id

    # in off topic context with confirmation pending
    if session.off_topic_id.present?
      off_topic = OffTopic.find(session.off_topic_id)
      Facebook::Api::send_buttons(session, off_topic.confirmation, [{'title': 'yes', 'payload': 'yes'}, {'title': 'no', 'payload': 'no'}])
      return
    
    # consider free text if not opening message
    elsif session.node_id.present?
  
      # compare free text input with button labels and try to match
      string_match = false
      platform.tree.edges_originating_from(parent_id).each do |edge|
        if edge.parent['label'].downcase == message_text.downcase
          parent_id = edge['target']
          string_match = true
          break
        end
      end
    
      # check for matching off topic
      if string_match == false
        puts DateTime.now.to_s
        off_topic_id, probability = Classifier::FastText::predict(message_text, platform.language_code)
        puts DateTime.now.to_s
        if probability > platform.threshold
          off_topic = OffTopic.find(off_topic_id)
          if off_topic.confirmation.present?
            session.update_attributes(off_topic: off_topic)
            Facebook::Api::send_buttons(session, off_topic.confirmation, [{'title': 'yes', 'payload': 'yes'}, {'title': 'no', 'payload': 'no'}])
          else
            off_topic.perform!(session)
          end

          return
        end
      end
    end

    handle_node(parent_id, session)
  end

  def self.handle_node(node_id, session)

    platform = session.platform

    # update user session with current node
    session.update_attributes(node_id: node_id.to_i)

    parent = platform.tree.get_node_by_id(node_id)

    while true do
      edges = platform.tree.edges_originating_from(parent['id'])

      # skip nodes with single edges because there is nothing to decide
      if edges.size == 1
        Facebook::Api::send_message(session, "#{parent['label']}: #{edges[0].parent['label']}")
        parent = platform.tree.get_node_by_id(edges[0]['target'])
      else
        break
      end
    end

    if edges.size > 1
      options = []
      edges.each do |edge|
        options.push({'title': edge.parent['label'], 'payload': edge['target']})
      end
      Facebook::Api::send_buttons(session, parent['label'], options)

    else
      # leaf node, here goes the action hook
      Facebook::Api::send_message(session, parent['label'])
      
      # call external service API here (optional)
      #ExternalService::Api::perform_action_hook(node_id, session)
    end
  end

end
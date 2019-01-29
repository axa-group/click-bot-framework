class OffTopic < ApplicationRecord
	has_many :training_messages, inverse_of: :off_topic, dependent: :destroy
	has_many :user_sessions

	validates :name, presence: true
	validates :response, presence: true
	validates_length_of :response, maximum: 640, message: "Facebook does not allow messages larger than 640 characters"

	accepts_nested_attributes_for :training_messages, allow_destroy: true, reject_if: :all_blank

	ACTION_HOOKS = ['exit', 'undo', 'help']

	def to_s
		name
	end

	def perform!(session)
		
		case action_hook
		when "exit" 
			# delete user session
			session.destroy unless session.blank?
			Facebook::Api::send_message(session, response)

		when "undo"
			# go back 1 step
			last_node_id = session.platform.tree.get_parent_node_id(session.node_id) || session.platform.tree.root_node_id
			session.update_attributes(node_id: last_node_id)
			Facebook::Api::send_message(session, response)
			Chatbot::handle_node(last_node_id, session)
			

		when "help"
			Facebook::Api::send_message(session, "Please ring our call center at 01.23.45.65.89")

		# no action hook, just reply with message
		else
			Facebook::Api::send_message(session, response)
		end
	end
end

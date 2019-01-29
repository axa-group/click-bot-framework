App.classifier_info = App.cable.subscriptions.create "ClassifierInfoChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	# Called when there's incoming data on the websocket for this channel
    if data["message"] == "training_scheduled"
      $("#train_classifier_button").addClass('disabled')
    else if data["message"] == "training_started"
  	  $("#train_classifier_button").text('Training ...');
    else if data["message"] == "training_completed"
      $("#train_classifier_button").text('Train classifier');
      $("#train_classifier_button").removeClass('disabled');
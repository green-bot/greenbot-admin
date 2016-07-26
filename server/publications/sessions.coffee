Meteor.publish "sessions", (botId) ->
  if botId?
    return Sessions.find({botId: botId})
  else
    return Sessions.find()

Meteor.publish "sessions", (botId) ->
  return Sessions.find({botId: botId})

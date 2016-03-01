Meteor.publish "sessions", (botId) ->
  console.log "Starting sessions publish for #{botId}"
  return Sessions.find({botId: botId})

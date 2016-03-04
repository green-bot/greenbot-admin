Meteor.methods({
  'deleteBot' : (botId) ->
    Bots.remove { _id: botId}
    console.log "Bot #{botId} removed from collection"
  })

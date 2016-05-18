Meteor.publish "bots", () ->
  console.log "Publishing bots for #{@userId}"
  Bots.find({accountId: @userId})

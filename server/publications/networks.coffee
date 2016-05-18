Meteor.publish "networks", () ->
  console.log "Publishing networks for #{@userId}"
  Networks.find()

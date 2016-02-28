Meteor.publish "bots", () ->
  return Bots.find({accountId: this.userId})

Meteor.publish "bots", () ->
  Bots.find({accountId: this.userId})

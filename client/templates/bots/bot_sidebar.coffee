
if Meteor.isClient
  Meteor.subscribe('bots')

  Template.botSidebar.helpers({
    bots: Bots.find({})
  })

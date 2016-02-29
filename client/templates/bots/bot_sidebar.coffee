
if Meteor.isClient
  Meteor.subscribe('bots')

  Template.botSidebar.helpers({
    bots: Bots.find({})
  })

  Template.botSidebar.events({
    'click .add-bot' : () ->
      Router.go('library')
      
    })

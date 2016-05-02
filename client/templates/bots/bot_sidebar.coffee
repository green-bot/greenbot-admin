
if Meteor.isClient
  Meteor.subscribe('bots')

  Template.botSidebar.helpers
    bots: Bots.find({accountId: Meteor.userId()})
    selected: ->
      instance = Template.parentData()
      if instance?._id is this._id
        style = "color: #FF5722;"
      else
        style = "color: white;"
      return style

  Template.botSidebar.events({
    'click .add-bot' : () ->
      Router.go('library')

    })

  Template.botSidebar.onRendered ->
    # Initialize collapse button
    this.$(".button-collapse").sideNav()
    $('.button-collapse').sideNav
      menuWidth: 240, # Default is 240
      edge: 'left', # Choose the horizontal origin
      closeOnClick: true # Closes side-nav on <a> clicks

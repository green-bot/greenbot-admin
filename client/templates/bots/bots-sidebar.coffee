Template.botsSidebar.helpers
  bots: ->
    Bots.find {}, sort: { name: 1 }

  activeStyle: ->
    instance = Template.parentData()
    if instance?._id is this._id
      return 'active'

Template.botsSidebar.events
  'click .add-bot' : () ->
    Router.go('botsNew')
  'click a.bot-item' : (e) ->
    Session.set('botId', @._id)

Template.botsSidebar.onRendered ->
  # Initialize collapse button
  this.$(".button-collapse").sideNav()
  $('.button-collapse').sideNav
    menuWidth: 240, # Default is 240
    edge: 'left', # Choose the horizontal origin
    closeOnClick: true # Closes side-nav on <a> clicks

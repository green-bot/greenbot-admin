
Router.route 'botSidebar',
  name: 'botSidebar'
  waitOn:  ->
    Meteor.subscribe "bots"
  action: ->
    this.render 'bot'


Template.botSidebar.helpers
  bots: ->
    Bots.find()

  activeStyle: ->
    instance = Template.parentData()
    if instance?._id is this._id
      return 'orange-text'
    return 'white-text'

Template.botSidebar.events
  'click .add-bot' : () ->
    Router.go('library')

Template.botSidebar.onRendered ->
  # Initialize collapse button
  this.$(".button-collapse").sideNav()
  $('.button-collapse').sideNav
    menuWidth: 240, # Default is 240
    edge: 'left', # Choose the horizontal origin
    closeOnClick: true # Closes side-nav on <a> clicks

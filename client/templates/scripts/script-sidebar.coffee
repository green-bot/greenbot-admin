Template.scriptSidebar.helpers
  scripts: ->
    Scripts.find()

  activeStyle: ->
    instance = Template.parentData()
    if instance?._id is this._id
      return 'orange-text'
    return 'white-text'

Template.scriptSidebar.events
  'click .add-script' : () ->
    Router.go('script')
  'click a.script-item' : (e) ->
    Session.set('scriptId', @._id)

Template.scriptSidebar.onRendered ->
  # Initialize collapse button
  this.$(".button-collapse").sideNav()
  $('.button-collapse').sideNav
    menuWidth: 240, # Default is 240
    edge: 'left', # Choose the horizontal origin
    closeOnClick: true # Closes side-nav on <a> clicks

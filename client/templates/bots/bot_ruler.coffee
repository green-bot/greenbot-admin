Template.botRuler.events
  'click #delete' : ->
    console.log "Deleting a bot in this context"
    console.log @
    Meteor.call('deleteBot', this._id)
    Router.go 'dashboard'

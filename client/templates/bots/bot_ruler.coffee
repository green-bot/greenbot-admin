Template.botRuler.events
  'click .delete' : ->
    Meteor.call('deleteBot', this._id)
    Router.go 'dashboard'

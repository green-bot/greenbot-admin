Template.botRuler.events({
  'click .settings' : ->
    Router.go 'botSettings', botId: this._id
  'click .convos' : ->
    Router.go 'botConvos', botId: this._id
  'click .delete' : ->
    Meteor.call('deleteBot', this._id)
    Router.go 'dashboard'
  })

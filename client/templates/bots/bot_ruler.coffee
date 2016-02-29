Template.botRuler.events({
  'click .settings' : ->
    Router.go 'botSettings', botId: this._id
  })

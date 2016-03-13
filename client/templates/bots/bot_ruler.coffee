Template.botRuler.events
  'click #delete' : ->
    Bots.remove this._id
    Router.go 'library'

Template.botRuler.helpers
  wikiName: -> Router.current().route.getName()
  currentBotId: ->
    return Router.current().params.botId

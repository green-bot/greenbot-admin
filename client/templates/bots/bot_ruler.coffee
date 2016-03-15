Template.botRuler.events
  'click #delete' : ->
    return unless confirm("Are you sure you want to delete this bot?")
    Bots.remove this._id
    Router.go 'library'

Template.botRuler.helpers
  wikiName: -> Router.current?().route?.getName() or "default"
  currentBotId: ->
    return Router.current().params.botId

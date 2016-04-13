Template.botRuler.events
  'click #delete' : ->
    return unless confirm("Are you sure you want to delete this bot?")

    Bots.remove(@._id)
    Router.go('library')


Template.botRuler.helpers
  wikiName: -> Router.currentDatarent?().route?.getName() or "default"
  currentBotId: -> Router.current().params.botId
  isScriptGone: -> !@scriptId?

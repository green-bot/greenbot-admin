Template.botRuler.events
  'click #delete' : ->
    return unless confirm("Are you sure you want to delete this bot?")

    Bots.remove(@._id)
    Router.go('library')


Template.botRuler.helpers
  wikiName: -> Router.currentTemplate?().route?.getName() or "default"
  currentBotId: -> Session.get('botId') #Router.current().params.botId
  isScriptGone: -> !@scriptId?

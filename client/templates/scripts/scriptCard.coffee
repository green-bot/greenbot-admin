Template.scriptCard.events
  'click .new_bot' : (event) ->
    bot =
      accountId: Meteor.userId()
      addresses: []
      description: this.short_desc
      name: this.name
      notificationEmails: Meteor.user().emails[0].address
      postConversationWebhook: null
      scriptId: this._id
      settings: this.default_settings
      ownerHandles: []
    newBotId = Bots.insert(bot)
    console.log newBotId
    Router.go 'bot', botId: newBotId

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

Template.scriptCard.helpers
  desc_markdown: ->
    marked(@desc)

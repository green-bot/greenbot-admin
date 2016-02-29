Template.scriptCard.events({
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
    Bots.insert(bot)
  })

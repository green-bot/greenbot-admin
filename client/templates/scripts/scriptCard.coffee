Template.scriptCard.events
  'click .new_bot' : (event) ->
    bot =
      accountId: Meteor.userId()
      description: this.short_desc
      name: this.name
      notificationEmails: Meteor.user().emails[0].address
      scriptId: this._id
      settings: this.default_settings
    newBotId = Bots.insert(bot)
    Meteor.call('addNetwork', newBotId, "development", newBotId.toLowerCase(), "test")
    Router.go 'bot', botId: newBotId

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    console.log 'Removing ' + @npm_pkg_name
    Meteor.call 'removeScript', @npm_pkg_name

Template.scriptCard.helpers
  desc_markdown: ->
    marked(@desc)

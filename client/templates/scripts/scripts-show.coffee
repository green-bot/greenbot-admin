simplePasscode = ->
  alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  code = ''
  for i in [1..6]
    index = Math.floor(Math.random() * 26)
    code += alpha.charAt(index)
  code

Template.scriptsShow.onRendered ->
  Session.set 'lastScriptViewedId', @data._id

Template.scriptsShow.helpers
  bots: ->
    console.log "In bots helper"
    bots = Bots.find(scriptId: @_id).fetch()
    console.log bots
    bots

Template.scriptsShow.events
  'click button#add-bot' : (e) ->
    console.log 'event'
    bot =
      accountId: Meteor.userId()
      description: this.short_desc
      name: this.name
      notificationEmails: Meteor.user().emails[0].address
      scriptId: this._id
      settings: this.default_settings
      passcode: simplePasscode()
    console.log bot
    newBotId = Bots.insert(bot)
    Meteor.call('addNetwork', newBotId, "development", newBotId.toLowerCase(), "test")
    Router.go 'bots', botId: newBotId

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    Meteor.call 'removeScript', @npm_pkg_name

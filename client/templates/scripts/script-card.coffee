simplePasscode = ->
  alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  code = ''
  for i in [1..6]
    index = Math.floor(Math.random() * 26)
    code += alpha.charAt(index)
  code

Template.scriptCard.events
  'click .select-script' : (event) ->
    bot =
      accountId: Meteor.userId()
      description: @short_desc
      name: @name
      notificationEmails: Meteor.user().emails[0].address
      scriptId: @_id
      settings: @default_settings
      passcode: simplePasscode()
    newBotId = Bots.insert(bot)
    Meteor.call('addNetwork', newBotId, "development", newBotId.toLowerCase(), "test")
    Router.go 'bots', botId: newBotId

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    Meteor.call 'removeScript', @npm_pkg_name

Template.scriptCard.helpers
  desc_markdown: ->
    marked(@desc)
  dropdownId: ->
    "#{this.name}-dropdown"

Template.scriptCard.onRendered ->
  $(".dropdown-button").dropdown(constrain_width: false)

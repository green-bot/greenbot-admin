simplePasscode = ->
  alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  code = ''
  for i in [1..6]
    index = Math.floor(Math.random() * 26)
    code += alpha.charAt(index)
  code

Template.scriptCard.events
  'click .select_bot' : (event) ->
    #bot =
      #accountId: Meteor.userId()
      #description: this.short_desc
      #name: this.name
      #notificationEmails: Meteor.user().emails[0].address
      #scriptId: this._id
      #settings: this.default_settings
      #passcode: simplePasscode()
    #newBotId = Bots.insert(bot)
    #Meteor.call('addNetwork', newBotId, "development", newBotId.toLowerCase(), "test")
    #Router.go 'bot', botId: newBotId

    thisBotSelected = Session.get('selectedBot') is this._id
    if thisBotSelected
      Session.set('selectedBot', null)
    else
      Session.set('selectedBot', this._id)

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    Meteor.call 'removeScript', @npm_pkg_name

Template.scriptCard.helpers
  desc_markdown: ->
    marked(@desc)
  dropdownId: ->
    "#{this.name}-dropdown"
  isSelected: ->
    Session.get('selectedBot') is this._id
  hide: ->
    thisBotSelected = Session.get('selectedBot') is this._id
    otherBotSelected = Session.get('selectedBot')? and not thisBotSelected
    if otherBotSelected
      'hide'
    else
      ''

Template.scriptCard.onRendered ->
  $(".dropdown-button").dropdown(constrain_width: false)

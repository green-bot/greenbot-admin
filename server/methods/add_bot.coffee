@simplePasscode = ->
  alpha = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  code = ''
  for i in [1..6]
    index = Math.floor(Math.random() * 26)
    code += alpha.charAt(index)
  code

Meteor.methods
  'addBot' : (data) ->
    if not this.userId
      throw new Meteor.Error 404, '[methods] addBot-> Invalid user'

    user = Meteor.users.findOne this.userId
    bot =
      accountId: this.userId
      description: data.short_desc
      name: data.name
      notificationEmails: user.emails[0].address
      scriptId: data._id
      settings: data.default_settings
      passcode: simplePasscode()

    newBotId = Bots.insert(bot)
    Meteor.call('addNetwork', newBotId, "development", newBotId.toLowerCase(), "test")
    return newBotId

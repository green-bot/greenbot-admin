Meteor.methods({
  'updateSetting' : (botId, name, value) ->
    Bots.update { _id: botId, 'settings.name': name },
                  $set: { 'settings.$.value': value }

  })

Meteor.methods
  updateBotName: (botId, name) ->
    if not this.userId
      throw new Meteor.Error 404, '[methods] addBot-> Invalid user'

    Bots.update botId,
      $set:
        name: name

  updateBotData: (botId, data) ->
    if not this.userId
      throw new Meteor.Error 404, '[methods] addBot-> Invalid user'

    Bots.update botId,
      $set :
        postConversationWebhook: data?.postConversationWebhook
        notificationEmails: data?.notificationEmails
        notificationEmailSubject: data?.notificationEmailSubject

  removeBotNetworkHandle: (botId, networkHandleId) ->
    if not this.userId
      throw new Meteor.Error 404, '[methods] addBot-> Invalid user'

    Bots.update botId,
      $pull :
        addresses: { networkHandleId: networkHandleId }

  updateNetworkAddress: (botId, updatedAddress) ->
    if not this.userId
      throw new Meteor.Error 404, '[methods] addBot-> Invalid user'

    Bots.update _id: botId, addresses: address,
      $set:
        'addresses.$': updatedAddress      
Meteor.methods
  'addNetwork' : (botId, network, handle, name, keywords) ->
    # First, add a new element to the networkHandles
    name = "#{network}::#{handle}"
    networkHandle = NetworkHandles.insert
      allocated: true
      handle: handle
      network: network
      keywords: keywords.split(",")
      default: false
      userId: Meteor.userId()
      name: name

    console.log "Added new network handle"
    console.log networkHandle

    address =
      networkHandleId: networkHandle
      networkHandleName: name
      keywords: keywords.split(",")
    Bots.update { _id: botId },
                  $push: { 'addresses': address }

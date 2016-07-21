Template.botNetworks.events
  'click  #add-network' : (e, tmpl) ->
    e.preventDefault()
    botId    = Router.current().params.botId
    network  = tmpl.$('#network').val().trim()
    handle   = tmpl.$('#handle').val().trim()
    keywords = tmpl.$('#keywords').val().trim()
    Meteor.call('addNetwork', botId, network, handle, keywords)
    tmpl.$('#network, #handle, #keywords').val("")
    console.log "Adding to networks : #{network}, #{handle}, #{keywords}"

  'click  .delete' : (e, tmpl) ->
    e.preventDefault()
    return unless confirm("Are you sure you want to delete this network hande?")
    botId = Router.current().params.botId
    Meteor.call 'removeBotNetworkHandle', botId, @.networkHandleId, (err, res) ->
      if not err
        console.log "The confirmation message was ... ... ..."
        console.log res

Template.botNetworks.helpers
  network: (networkHandleName) -> networkHandleName.split("::")[0]
  handle:  (networkHandleName) -> networkHandleName.split("::")[1]
  availableNetworks: -> Networks.find()

Template.botNetworks.onRendered ->
  this.$('#networks .material-icons').css('color', '#FF5722')

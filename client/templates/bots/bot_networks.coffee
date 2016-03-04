Template.botNetworks.events
  'click  #add-network' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    network = tmpl.$('#network').val()
    handle = tmpl.$('#handle').val()
    keywords = tmpl.$('#keywords').val()
    Meteor.call('addNetwork', botId, network, handle, name, keywords)
    console.log "Adding to networks : #{network}, #{handle}, #{keywords}"
    return

  'click  .delete' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    console.log "My data context is..."
    console.log this
    result = Bots.update({_id: botId},
      { $pull : { addresses: {networkHandleId: @.networkHandleId } }})
    console.log "The confirmation message was ... ... ..."
    console.log result
    return


Template.botNetworks.helpers
  network: (networkHandleName) ->
    networkHandleName.split("::")[0]
  handle: (networkHandleName) ->
    networkHandleName.split("::")[1]

Template.botNetworks.onRendered ->
  this.$('#networks').addClass('green')

Router.route '/bot/:botId/networks',
  name: 'networks'
  waitOn: ->
    Meteor.subscribe "bots"
    Meteor.subscribe "networkHandles", this.params._id
    Meteor.subscribe "sessions", this.params.botId
  data: ->
    return Bots.findOne this.params.botId
  action: ->
    this.render 'botNetworks'
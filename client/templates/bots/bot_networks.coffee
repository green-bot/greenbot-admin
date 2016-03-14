Template.botNetworks.events
  'click  #add-network' : (e, tmpl) ->
    e.preventDefault()
    botId    = Router.current().params.botId
    network  = tmpl.$('#network').val()
    handle   = tmpl.$('#handle').val()
    keywords = tmpl.$('#keywords').val()
    Meteor.call('addNetwork', botId, network, handle, name, keywords)
    tmpl.$('#network, #handle, #keywords').val("")
    console.log "Adding to networks : #{network}, #{handle}, #{keywords}"

  'click  .delete' : (e, tmpl) ->
    e.preventDefault()
    return unless confirm("Are you sure you want to delete this network hande?")
    botId = Router.current().params.botId
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
  availableNetworks: ->
    Networks.find()

Template.botNetworks.onRendered ->
  this.$('#networks').addClass('green')
  $('select').material_select()

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

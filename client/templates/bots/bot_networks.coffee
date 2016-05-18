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
    result = Bots.update({_id: botId},
      { $pull : { addresses: {networkHandleId: @.networkHandleId } }})
    console.log "The confirmation message was ... ... ..."
    console.log result
    return


Template.botNetworks.helpers
  network: (networkHandleName) -> networkHandleName.split("::")[0]
  handle:  (networkHandleName) -> networkHandleName.split("::")[1]
  availableNetworks: -> Networks.find()

Template.botNetworks.onRendered ->
  this.$('#networks .material-icons').css('color', '#FF5722')

Router.route '/bot/:botId/networks',
  name: 'networks'
  waitOn: ->
    Meteor.subscribe "bots"
    Meteor.subscribe "networkHandles", this.params._id
    Meteor.subscribe "sessions", this.params.botId
    Meteor.subscribe 'networks'
  data: -> Bots.findOne this.params.botId
  action: -> this.render 'botNetworks'

Template.botData.helpers
  emailChips: ->
    Session.get("emailChips") or @.notificationEmails.split(',')

Template.botData.events
  'input input[name=notificationEmails]' : (e, tmpl) ->
    val = $(e.target).val()
    console.log "input event fired"
    Session.set('emailChips', val.split(','))

  'click .submit' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    postConversationWebhook = tmpl.$('input[name=postConversationWebhook]').val()
    notificationEmails = tmpl.$('input[name=notificationEmails]').val()
    console.log "Updating data sinks"
    console.log postConversationWebhook
    console.log notificationEmails
    Bots.update { _id: botId },
      $set :
        postConversationWebhook: postConversationWebhook
        notificationEmails: notificationEmails


Template.botData.onRendered ->
  this.$('#data').addClass('green')

Router.route '/bot/:botId/data',
  name: 'data'
  waitOn: ->
    Meteor.subscribe "bots"
    Meteor.subscribe "networkHandles", this.params._id
    Meteor.subscribe "sessions", this.params.botId
  data: ->
    return Bots.findOne this.params.botId
  action: ->
    this.render 'botData'

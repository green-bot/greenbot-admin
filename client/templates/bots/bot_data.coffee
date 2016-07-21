Template.botData.helpers
  emailChips: ->
    Session.get("emailChips") or @.notificationEmails.split(',')

Template.botData.events
  'input input[name=notificationEmails]' : (e, tmpl) ->
    val = $(e.target).val()
    console.log "input event fired"
    Session.set('emailChips', val.split(','))

  'click .submit2' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    data =
      postConversationWebhook: tmpl.$('input[name=postConversationWebhook]').val()
      notificationEmails: tmpl.$('input[name=notificationEmails]').val()
      notificationEmailSubject: tmpl.$('input[name=notificationEmailSubject]').val()

    Meteor.call 'updateBotData', botId, data, (err, res) ->
      if not err
        toastr.success 'Saved!'

Template.botData.onRendered ->
  this.$('#data .material-icons').css('color', '#FF5722')
  AutoForm.setDefaultTemplate('materialize')

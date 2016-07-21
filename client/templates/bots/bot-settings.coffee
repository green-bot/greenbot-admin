saving = new ReactiveVar(false)

Template.botSettings.events
  'click .submit' : (e, tmpl) ->
    saving.set true
    e.preventDefault()
    botId = Router.current().params.botId
    inputs = tmpl.$('.setting').each (index, element) ->
      name = $(this).prop('name')
      value = $(this).prop('value')
      Meteor.call('updateSetting', botId, name, value)
    name = tmpl.$('.name').prop('value')
    Bots.update botId, $set: { name: name }, (err) ->
      console.log(err) if err?
      unless err?
        saving.set(false)
        toastr.success 'Saved!', positionClass: 'toastr-bottom-right'

Template.botSettings.helpers
  script: ->
    script = Scripts.findOne(@scriptId)
    script
  settings: -> this.settings
  saveMessage: ->
    if saving.get()
      message = 'Saving'
    else
      message = 'Save'
    message

Template.botSettings.onRendered ->
  this.$('#settings .material-icons').css('color', '#FF5722')
  this.$('.setting').characterCounter()


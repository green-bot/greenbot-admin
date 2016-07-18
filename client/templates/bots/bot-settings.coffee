Template.botSettings.events
  'click .submit' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    inputs = tmpl.$('.setting').each (index, element) ->
      name = $(this).prop('name')
      value = $(this).prop('value')
      Meteor.call('updateSetting', botId, name, value)
    name = tmpl.$('.name').prop('value')
    Bots.update botId,
      $set:
        name: name
    return

Template.botSettings.helpers
  script: ->
    script = Scripts.findOne(@scriptId)
    script
  settings: -> this.settings

Template.botSettings.onRendered ->
  this.$('#settings .material-icons').css('color', '#FF5722')
  this.$('.setting').characterCounter()


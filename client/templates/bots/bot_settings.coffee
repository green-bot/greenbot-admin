Template.botSettings.events
  'click .submit' : (e, tmpl) ->
    e.preventDefault()
    botId = Router.current().params.botId
    inputs = tmpl.$('input').each (index, element) ->
      name = $(this).prop('name')
      value = $(this).prop('value')
      Meteor.call('updateSetting', botId, name, value)
    return

Template.botSettings.helpers
  script: ->
    script = Scripts.findOne(@scriptId)
    script
  settings: ->
    this.settings

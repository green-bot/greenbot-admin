Template.botCard.events
  'click .bot-button': (event) ->
    Router.go 'bot', botId: this._id

Template.botCard.helpers
  selected: ->
    instance = Template.parentData()
    if instance?._id is this._id
      style = ""
    else
      style = "darken-2"
    return style

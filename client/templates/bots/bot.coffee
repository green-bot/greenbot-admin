Template.bot.helpers
  sessions: () -> Sessions.find({botId: this._id})
  collectedDataArray: () ->
    return [] unless this.collectedData?
    collectedDataArray = []
    keys = Object.keys(this.collectedData)
    collectedDataArray.push { key: key, val: this.collectedData[key] } for key in keys
    return collectedDataArray
  dateString: () -> moment(this.updatedAt).fromNow()
  desc_markdown: () -> Session.get('readme')
  isScriptGone: -> !@scriptId?

Router.route '/bot/:botId',
  name: 'bot'
  waitOn:  ->
    Meteor.subscribe "bots"
    Meteor.subscribe "scripts"
    Meteor.subscribe "sessions", this.params.botId
  data: ->
    return Bots.findOne this.params.botId
  action: ->
    this.render 'bot'

Template.bot.onRendered ->
  this.$('#info .material-icons').css('color', '#FF5722')
  Meteor.call 'getReadme', @data.scriptId, (err, res) ->
    if err
      console.log "Read me threw error"
      console.log err
      return ""
    console.log res
    Session.set 'readme', marked(res)

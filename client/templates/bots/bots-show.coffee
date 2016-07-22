Template.botsShow.helpers
  sessions: -> Sessions.find({botId: @_id})
  collectedDataArray: ->
    return [] unless this.collectedData?
    collectedDataArray = []
    keys = Object.keys(this.collectedData)
    collectedDataArray.push { key: key, val: this.collectedData[key] } for key in keys
    return collectedDataArray
  dateString: -> moment(this.updatedAt).fromNow()
  desc_markdown: -> Session.get('readme')
  isScriptGone: -> !@scriptId?
  id: -> this._id
  bot: -> Bots.findOne this._id
  readme: ->
    marked(Scripts.findOne(_id: @scriptId)?.readme)

Template.botsShow.onRendered ->
  console.log 'rendered'
  Session.set 'lastBotViewedId', @data._id
  console.log @data.scriptId
  this.$('#info .material-icons').css('color', '#FF5722')

Template.botsShow.onCreated ->
  self = this
  self.readme = new ReactiveVar()

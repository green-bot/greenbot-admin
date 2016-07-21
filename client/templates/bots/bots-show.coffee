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
    Template.instance().readme.get()

Template.botsShow.onRendered ->
  console.log 'rendered'
  Session.set 'lastBotViewedId', @data._id
  this.$('#info .material-icons').css('color', '#FF5722')
  @readme = new ReactiveVar()
  this.autorun =>
    console.log 'Getting readme'
    if Session.get('botsShow.botId')
      Meteor.call 'getReadme', @data.scriptId, (err, res) =>
        console.log 'Got the readme'
        if err
          console.log "Read me threw error"
          console.log err
          return ""
        @readme.set marked(res)


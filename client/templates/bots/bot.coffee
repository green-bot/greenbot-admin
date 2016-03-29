Template.bot.helpers({
  sessions: () ->
    Sessions.find({botId: this._id})
  collectedDataArray: () ->
    return [] unless this.collectedData?
    collectedDataArray = []
    keys = Object.keys(this.collectedData)
    collectedDataArray.push { key: key, val: this.collectedData[key] } for key in keys
    return collectedDataArray
  dateString: () ->
    moment(this.updatedAt).fromNow()
  desc_markdown: () ->
    script = Scripts.findOne _id: @.scriptId
    return marked(script.desc)
  })

Router.route '/bot/:botId',
  name: 'bot'
  waitOn:  ->
    Meteor.subscribe "bots"
    Meteor.subscribe "scripts"
    Meteor.subscribe "sessions", this.params.botId
  data:  ->
    return Bots.findOne this.params.botId
  action:  ->
    this.render 'bot'

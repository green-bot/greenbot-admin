if Meteor.isClient
  Meteor.subscribe("sessions", this._id)
  Template.registerHelper 'currentBotId', -> Session.get('currentBotId')


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
  })

Template.bot.onRendered ->
  console.log "Bot template rendered"
  console.log this

Router.route '/bot/:botId',
  name: 'bot'
  waitOn:  ->
    Meteor.subscribe "bots"
  data:  ->
    Session.set 'currentBotId', this.params.botId
    return Bots.findOne this.params.botId
  action:  ->
    console.log "Rendering a bot"
    console.log this
    this.render 'bot'

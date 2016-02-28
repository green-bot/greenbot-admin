if Meteor.isClient
  Meteor.subscribe("sessions", this._id)


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

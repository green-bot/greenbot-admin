fileSaver = require 'filesaver.js'
collectedData = new ReactiveVar({})
transcriptData = new ReactiveVar([])

Template.botConvos.helpers
  tableSettings: ->
    fields: [
        key: 'updatedAt'
        label: 'Updated At'
        fn: (value) -> moment(value).format('l')
      ,
        key: 'src'
        label: 'Source'
      ,
        key: 'transcript'
        label: 'Transcript'
        tmpl: Template.conversationTableTranscript
      ,
        key: 'collectedData'
        label: 'Data'
        tmpl: Template.conversationTableCollectedData
    ]

  convoData: (collectedData) ->
    data = []
    for k,v in collectedData
      data.push {k: k, v: v}
    data

  collectedData: -> collectedData.get()
  transcriptData: -> transcriptData.get()
  convos: -> Sessions.find({botId: @_id}).fetch()

Template.botConvos.events
  'click .show-data' : (e, tmpl)->
    collectedData.set(@.collectedData)
    $('#collected-data-modal').openModal()

  'click .show-transcript' : (e, tmpl)->
    transcriptData.set(@.transcript)
    $('#transcript-modal').openModal()

  'click .csv-export': (e, tmpl) ->
    selector = botId: @_id
    Meteor.call 'exportSessions', selector, (err, data) ->
      if data?
        blob = new Blob([data], {type: "text/plain;charset=utf-8"})
        saveAs blob, 'greenbot-sessions.csv'

Router.route '/bot/:botId/convos',
  name: 'botConvos'
  waitOn: ->
    Meteor.subscribe "sessions", this.params.botId
    Meteor.subscribe 'bots'
    
  action: ->
    this.render 'botConvos'
  data: ->
    Bots.findOne this.params.botId

Template.botConvos.onRendered ->
  this.$('#convos .material-icons').css('color', '#FF5722')

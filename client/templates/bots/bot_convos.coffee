collectedData = new ReactiveVar({})
transcriptData = new ReactiveVar([])

Template.botConvos.helpers
  convos: ->
    Template.instance().data
  tableSettings: ->
    fields: [
        key: 'updatedAt'
        label: 'Updated At'
        fn: (value) -> moment(value).format('l')
      ,
        key: 'transcript'
        label: 'Transcript'
        tmpl: Template.conversationTableTranscript
      ,
        key: 'src'
        label: 'Source'
      ,
        key: 'dst'
        label: 'Destination'
      ,
        key: 'collectedData'
        label: 'Data'
        tmpl: Template.conversationTableCollectedData
      ,
        key: 'sessionId'
        label: 'Session ID'
      ,
        key: 'lang'
        label: 'Language'
    ]

  convoData: (collectedData) ->
    data = []
    for k,v in collectedData
      data.push {k: k, v: v}
    data

  collectedData: -> collectedData.get()
  transcriptData: -> transcriptData.get()

Template.botConvos.events
  'click .show-data' : (e, tmpl)->
    collectedData.set(@.collectedData)
    $('#collected-data-modal').openModal()

  'click .show-transcript' : (e, tmpl)->
    transcriptData.set(@.transcript)
    $('#transcript-modal').openModal()

Router.route '/bot/:botId/convos',
  name: 'botConvos'
  waitOn: ->
    Meteor.subscribe "sessions", this.params.botId
  action: ->
    this.render 'botConvos'
  data: ->
    Sessions.find({botId: this.params.botId}).fetch()

Router.route '/bot/:botId/convos/:sessionId',
  name: 'session.show'
  waitOn: ->
    Meteor.subscribe "sessions", this.params.botId
  action: ->
    this.render 'sessionShow'
  data: ->
    Sessions.find({sessionId: this.params.sessionId}).fetch()[0]

Template.botConvos.onRendered ->
  this.$('#convos').addClass('green')

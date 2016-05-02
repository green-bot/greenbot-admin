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

Router.route '/bot/:botId/convos',
  name: 'botConvos'
  waitOn: ->
    Meteor.subscribe "sessions", this.params.botId
  action: ->
    this.render 'botConvos'
  data: ->
    Bots.findOne this.params.botId


Template.botConvos.onRendered ->
  this.$('#convos .material-icons').css('color', '#FF5722')

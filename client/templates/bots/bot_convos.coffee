Template.botConvos.helpers({
  convos: ->
    Template.instance().data

  convoData: (collectedData) ->
    data = []
    for k,v in collectedData
      data.push {k: k, v: v}
    data
})

Router.route '/bot/:botId/convos',
  name: 'botConvos'
  waitOn: ->
    Meteor.subscribe "sessions", this.params.botId
  action: ->
    this.render 'botConvos'
  data: ->
    return Sessions.find({botId: this.params.botId}).fetch()


Template.botConvos.onRendered ->
  this.$('#convos').addClass('green')

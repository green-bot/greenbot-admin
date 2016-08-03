Chart = require('chart.js')

Template.home.events
  'click .reactive-table a.sessions-delete': (ev) ->
    ev.preventDefault()
    Meteor.call 'killSession', @sessionId, (err, res) ->
      if err?
        console.log 'Error killing session'
        console.log err

Template.home.helpers
  activeSessions: ->
    Sessions.find({ completedAt: null })

  tableSettings: ->
    fields: [
        key: 'updatedAt'
        label: 'Updated At'
        fn: (value) -> moment(value).format('l')
      ,
        key: 'src'
        label: 'Source'
      ,
        key: 'dst'
        label: 'Destination'
      ,
        key: 'botId'
        label: 'Bot'
        fn: (botId, session) -> Bots.findOne(botId).name
      ,
        key: ''
        label: 'Kill Session'
        tmpl: Template.sessionsDeleteButton
    ]
  bots: ->
    return Bots.find()

Template.home.onRendered ->
  self = this
  self.autorun ->
    sessionsForChart = Template.currentData() or []
    datalabels = []
    datapoints = []
    numDays = 14
    i = numDays - 1
    while i >= 0
      date = moment().subtract(i, 'days')
      datalabels.push date.format('MMM DD')
      sessionsCount = _.filter(sessionsForChart, (s) ->
        s.createdAt >= date.startOf('day')._d and s.createdAt < date.endOf('day')._d
      ).length
      datapoints.push sessionsCount
      i--
    chartData =
      labels: datalabels
      datasets: [ {
        fillColor: 'rgba(220,220,220,0.2)'
        strokeColor: 'rgba(220,220,220,1)'
        pointColor: 'rgba(220,220,220,1)'
        pointStrokeColor: '#fff'
        pointHighlightFill: '#fff'
        pointHighlightStroke: 'rgba(220,220,220,1)'
        data: datapoints
      } ]
    ctx = document.getElementById('chart').getContext('2d')
    @chartObj = new Chart(ctx).Line(chartData,
      responsive: true
      animation: false)

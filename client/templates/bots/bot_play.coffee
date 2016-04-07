Template.botPlay.events
  'click #restart': -> BotTest.restart()

Template.botPlay.onRendered ->
  outerContext = @
  $.getScript 'https://cdn.socket.io/socket.io-1.4.5.js', ->
    bot = outerContext.data
    handle = bot._id.toLowerCase()

    testNH = _.find(bot.addresses, (addr)-> addr.networkHandleName is "development::#{ handle }" )
    keyword = testNH.keywords[0]
    BotTest.init(handle, keyword)

Template.botPlay.onDestroyed ->
  BotTest.disconnect()

Router.route '/bot/:botId/play',
  name: 'botPlay'
  waitOn: ->
    Meteor.subscribe "bots"
  data: ->
    Bots.findOne this.params.botId
  action: ->
    this.render 'botPlay'

BotTest =
  restart: ->
    @disconnect()
    @init(@handle, @keyword)

  init: (@handle, @keyword)->
    self = this
    @sessionId    = (new Date).getTime().toString()
    @convosDiv    = $('.conversation')
    @logContainer = $('#log')
    @convosDiv.html("")
    @logContainer.html("")
    $('form input').prop('disabled', false)

    $('form').off('submit').on 'submit', ->
      input = $(this).find('input')
      self.sendMsg(input.val())
      input.val ''
      false

    @io = io('localhost:3003')
    @sendMsg(@keyword)

    @io.on 'egress', (msg) ->
      return if self.sessionId isnt msg.dst
      self.drawMessage 'their', msg.txt
    @io.on 'session:ended', (sess) ->
      console.log sess
      $('form input').prop('disabled', true)
      self.logContainer.append("<p>Session has ended. You may start it over by pressing 'restart conversation' button.</p>")

  disconnect: -> @.io.disconnect()

  sendMsg: (txt) ->
    msg =
      dst: "development::#{ @handle }"
      src: @sessionId
      txt: txt + '\n'
    @io.emit 'ingress', msg
    @drawMessage 'mine', msg.txt

  drawMessage: (direction, txt) ->
    msgHtml = $("<div class='message-wrapper'><div class='message message-#{direction}'><div class='text'>#{txt}</div><div class='message-timestamp'>#{ moment().format("HH:m") }</div></div></div>")
    self = @
    @convosDiv.append msgHtml
    self.convosDiv.animate { scrollTop: @convosDiv[0].scrollHeight }, '500', 'swing'

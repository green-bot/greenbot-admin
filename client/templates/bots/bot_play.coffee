collectedData = new ReactiveVar()
selectedNetworkHandle = new ReactiveVar()

Template.botPlay.helpers
  collectedData: -> collectedData.get()
  isNetworkHandleSelected: -> selectedNetworkHandle.get()?
  networkHandles: ->
    Template.instance().data.addresses.map (a) -> a.networkHandleName

Template.botPlay.events
  'change #network-handle': (event, template)->
    console.log 'changed'
    selectedNetworkHandle.set $(event.target).val()
  'submit #send-message-form': (event, template) ->
    event.preventDefault()
    input = $(event.target).find('input')
    BotTest.sendMsg(input.val())
    input.val ''

Template.botPlay.onRendered ->
  this.$('#test .material-icons').css('color', '#FF5722')
  $('select').material_select()
  bot = @.data

  $.getScript Meteor.settings.public.GREENBOT_IO_URL+'/socket.io/socket.io.js',  =>
    BotTest.init()

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
  init: ->
    self = this
    @src    = (new Date).getTime().toString()
    @convosDiv    = $('.conversation')
    @logContainer = $('#log')
    @convosDiv.html("")
    @logContainer.html("")
    #$('form input').prop('disabled', false)
    #


    socketUrl = Meteor.settings.public.GREENBOT_IO_URL
    console.log socketUrl
    connect = ->
      io.connect(socketUrl, {
        reconnection: true,
        reconnectionDelay: 1000,
        reconnectionDelayMax : 5000,
        reconnectionAttempts: Infinity
      })

    @io = connect()
    @io.on 'connect', -> console.log 'connected to server'
    @io.on 'disconnect', ->
      console.log 'disconnected from server'
      window.setTimeout connect, 5000
      
    #@sendMsg(@keyword)

    @io.on 'egress', (msg) ->
      return if self.src isnt msg.dst
      self.drawMessage 'their', msg.txt

    @io.on 'session:ended', (sess) =>
      return unless sess.src is @src
      console.log sess
      #$('ul.tabs li').removeClass('disabled')
      #$('form input').prop('disabled', true)
      collectedData.set(sess.collectedData)
      self.logContainer.append("<p>Session has ended. You may start it over by pressing 'restart conversation' button.</p>")
      @disconnect()

  disconnect: -> #@io.disconnect()

  sendMsg: (txt) ->
    msg =
      dst: selectedNetworkHandle.get()
      src: @src
      txt: txt + '\n'
    @io.emit 'ingress', msg
    @drawMessage 'mine', msg.txt

  drawMessage: (direction, txt) ->
    msgHtml = $("<div class='message-wrapper'><div class='message message-#{direction}'><div class='text'>#{txt}</div><div class='message-timestamp'>#{ moment().format("HH:m") }</div></div></div>")
    self = @
    @convosDiv    = $('.conversation')
    @convosDiv.append msgHtml
    self.convosDiv.animate { scrollTop: @convosDiv[0].scrollHeight }, '500', 'swing'

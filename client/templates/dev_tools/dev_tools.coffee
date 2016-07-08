collectedData = new ReactiveVar()
selectedNetworkHandle = new ReactiveVar()

socketUrl = Meteor.settings.public.GREENBOT_IO_URL
getConnection = (ioInstance) ->
  console.log 'getting connection'
  ioInstance.connect(socketUrl, {
    reconnection: true,
    reconnectionDelay: 1000,
    reconnectionDelayMax : 5000,
    reconnectionAttempts: Infinity
  })

getIo = new Promise (resolve, reject) =>
  console.log 'I promise'
  cachedIO = Session.get('socketIO')
  if cachedIO?
    console.log 'cached io'
    resolve cachedIO
  else
    $.getScript(  "#{socketUrl}/socket.io/socket.io.js" )
      .done ->
        console.log 'done'
        Session.set('socketIO', window.io)
        resolve window.io
      .fail ->
        console.log 'failed to get socket.io js'

Template.devTools.helpers
  collectedData: -> collectedData.get()
  isNetworkHandleSelected: -> selectedNetworkHandle.get()?
  isSelected: (handle) -> handle is selectedNetworkHandle.get()
  networkHandles: ->
    networkHandles = {}
    Bots.find().fetch().forEach (bot) ->
      bot.addresses.forEach (address) ->
        name = address.networkHandleName
        networkHandles[name] ?= []
        networkHandles[name].push(bot.name) unless bot.name in networkHandles[name]
    #networkHandleNames = _.uniq(_.flatten(networkHandleNames)).sort (a, b) ->
      #a = a.toLowerCase()
      #b = b.toLowerCase()
      #if (a < b) return -1
      #if (a > b) return 1
      #return 0

    arrayifiedHandles = []
    for handle, bots of networkHandles
      arrayifiedHandles.push(handle: handle, bots: bots.join(", "))
    arrayifiedHandles

Template.devTools.events
  'change #network-handle': (event, template) ->
    selectedNetworkHandle.set $(event.target).val()
    Meteor.defer ->
      $('#send-message-form input').focus()

  'submit #send-message-form': (event, template) ->
    event.preventDefault()
    input = $(event.target).find('input')
    BotTest.sendMsg(input.val())
    input.val ''

Template.devTools.onCreated ->
  console.log 'created'

Template.devTools.onRendered ->
  console.log 'rendered'
  collectedData.set(null)
  this.$('#test .material-icons').css('color', '#FF5722')
  $('select').material_select()
  bot = @.data

  getIo.then (io) ->
    connection = getConnection(io)
    BotTest.init(connection)

Template.devTools.onDestroyed ->
  BotTest.disconnect()

Router.route '/dev-tools/:networkHandle?',
  name: 'devTools'
  data: ->
    selectedNetworkHandle.set(this.params.networkHandle)
  waitOn: ->
    Meteor.subscribe "bots"
  action: ->
    this.render 'devTools'

BotTest =
  init: (@io) ->
    console.log 'init'
    self = this
    @src = (new Date).getTime().toString()
    @convosDiv = $('.conversation')
    @logContainer = $('#log')
    @convosDiv.html("")
    @logContainer.html("")

    @io.on 'connect', -> console.log 'connected to server'
    @io.on 'disconnect', ->
      console.log 'disconnected from server'

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
      #@disconnect()

  disconnect: -> @io.disconnect()

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

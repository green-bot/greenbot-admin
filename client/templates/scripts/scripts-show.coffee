Template.scriptsShow.onRendered ->
  Session.set 'lastScriptViewedId', @data._id

Template.scriptsShow.helpers
  bots: ->
    console.log "In bots helper"
    bots = Bots.find(scriptId: @_id).fetch()
    console.log bots
    bots

Template.scriptsShow.events
  'click button#add-bot' : (e) ->
    Meteor.call 'addBot', @, (err, res) ->
      if not err
        Router.go "/bots/#{res}"
      else
        console.log '!!!!err'
        console.log err

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    $('.overlay').LoadingOverlay("show")
    Meteor.call 'removeScript', @npm_pkg_name, (err)->
      if err
        console.log err
      else
        firstScriptId = Scripts.findOne({}, sort: { name: 1 } )._id
        console.log firstScriptId
        Router.go "/scripts/#{firstScriptId}"
        $('.overlay').LoadingOverlay("hide")
        toastr.success('Script removed!')

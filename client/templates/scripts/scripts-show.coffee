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
        Router.go 'bots', botId: res

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    Meteor.call 'removeScript', @npm_pkg_name

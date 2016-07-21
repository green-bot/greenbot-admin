Template.scriptCard.events
  'click .select-script' : (event) ->
    Meteor.call 'addBot', @, (err, res)->
      if not err
        Router.go 'bots', botId: res

  'click .info' : (event, template) ->
    template.$('#desc').openModal()

  'click .remove' : (event, template) ->
    Meteor.call 'removeScript', @npm_pkg_name

Template.scriptCard.helpers
  desc_markdown: ->
    marked(@desc)
  dropdownId: ->
    "#{this.name}-dropdown"

Template.scriptCard.onRendered ->
  $(".dropdown-button").dropdown(constrain_width: false)

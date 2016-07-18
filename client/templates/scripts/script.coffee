Template.script.helpers({
  scripts: () ->
    scripts = Scripts.find()
  })

Template.script.events
  'click .addScript' : (e, tmpl) ->
    e.preventDefault()
    pkgName = tmpl.$('input.pkg').prop('value')
    console.log 'adding ' + pkgName
    Meteor.call 'installScriptViaNpm', pkgName

Template.script.onRendered ->
  this.subscribe('scripts')

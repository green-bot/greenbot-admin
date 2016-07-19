Template.scripts.helpers({
  scripts: () ->
    scripts = Scripts.find()
  })

Template.scripts.events
  'click .install-script' : (e, tmpl) ->
    e.preventDefault()
    pkgName = tmpl.$('input.package').prop('value')
    console.log 'adding ' + pkgName
    Meteor.call 'installScriptViaNpm', pkgName

Template.scripts.onRendered ->
  this.subscribe('scripts')

Template.scripts.helpers
  firstScript: ->
    Scripts.findOne({}, {sort: {createdAt: 1}})

Template.library.helpers({
  scripts: () ->
    scripts = Scripts.find()
  })

Router.route  '/library', {
  name:               'library',
  action:             -> this.render('library'),
  layoutTemplate:     'libraryLayout',
  waitOn:             -> this.subscribe('scripts')

  }

Template.library.events
  'click .addScript' : (e, tmpl) ->
    e.preventDefault()
    pkgName = tmpl.$('input.pkg').prop('value')
    console.log 'adding ' + pkgName
    Meteor.call 'installScriptViaNpm', pkgName

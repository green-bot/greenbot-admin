Template.library.helpers({
  scripts: () ->
    scripts = Scripts.find()
  })

Router.route  '/library', {
  name:               'library',
  action:             -> this.render('library'),
  waitOn:             ->
    this.subscribe('scripts')
    this.subscribe('bots')
  }

Template.library.events
  'click .addScript' : (e, tmpl) ->
    e.preventDefault()
    pkgName = tmpl.$('input.pkg').prop('value')
    console.log 'adding ' + pkgName
    Meteor.call 'installScriptViaNpm', pkgName

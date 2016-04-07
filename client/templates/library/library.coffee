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
    console.log "click"
    e.preventDefault()
    inputs = tmpl.$('.pkg').each (index, element) ->
      pkg = tmpl.$('.pkg').prop('value')
      console.log 'adding ' + pkg
      Meteor.call 'installScript', pkg

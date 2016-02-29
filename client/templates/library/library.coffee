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

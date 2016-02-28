Router.route '/login',
  name: 'loginPage'
  action: -> this.render('loginPage')
  layoutTemplate: 'noAuthLayout'

Router.route '/logout', action: -> Meteor.logout()

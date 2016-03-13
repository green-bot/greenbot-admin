Router.route '/login',
  name: 'loginPage'
  layoutTemplate: 'noAuthLayout'
  action: ->
    if Meteor.userId()
      this.redirect '/dashboard'
      this.next()
    else
      this.render('loginPage')

Router.route '/logout',
  action: ->
    Meteor.logout()
    this.redirect 'loginPage'
    this.next()


Router.onBeforeAction ->
  if !Meteor.userId()
    # if the user is not logged in, render the Login template
    this.redirect 'loginPage'
  this.next()

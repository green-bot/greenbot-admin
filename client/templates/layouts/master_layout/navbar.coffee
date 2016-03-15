Template.navbar.events
  'click .logout' : (e) ->
    e.preventDefault()
    Meteor.logout()
    Router.go('/')

Template.navbar.helpers
  wikiName: -> Router.current().route.getName()

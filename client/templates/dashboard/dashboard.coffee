Template.dashboard.helpers({
  bots: () ->
    Bots.find()
  })



Router.route '/dashboard',
  name: 'dashboard'
  action: -> this.render 'dashboard'

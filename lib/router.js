Router.route('/number_porting_requests', {
  name: 'numberPortingRequestList',
  waitOn(){ Meteor.subscribe("numberPortingRequests") },
  action(){ this.render('numberPortingRequestList') }
});

Router.route('/number_porting_requests/new', {
  name: 'numberPortingRequestNew',
  action(){ this.render('numberPortingRequestNew') }
});

Router.route('/bots/:_id/addresses/:networkHandleName', {
  name: 'networkAddressShow',
  waitOn(){ return Meteor.subscribe("bot", this.params._id); },
  data(){ return Bots.findOne(); },
  action(){ this.render('networkAddressShow') },
});


Router.route('/number_porting_requests/:_id/edit', {
  name: 'numberPortingRequestEdit',
  layoutTemplate: 'noAuthLayout',
  waitOn(){
    Meteor.subscribe("numberPortingRequest", this.params._id);
  },
  data(){ return NumberPortingRequests.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('numberPortingRequestEdit') },
  controller: 'UnauthenticatedController'
});


Router.route('/number_porting_requests/:_id', {
  name: 'numberPortingRequestShow',
  layoutTemplate: 'noAuthLayout',
  waitOn(){
    Meteor.subscribe("numberPortingRequest", this.params._id);
  },
  data(){ return NumberPortingRequests.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('numberPortingRequestShow') },
  controller: 'UnauthenticatedController'
});

Router.route('/port_start_notifications/new', {
  name: 'portStartNotificationNew',
  action() { this.render('portStartNotificationNew'); },
  waitOn() { Meteor.subscribe('numberPortingRequestsByIds', Session.get('nprIdsToPort')); }
});

Router.route('/accounts/new', {
  name: 'accountsNew',
  action() { this.render('accountsNew'); }
});

Router.route('/accounts/:_id/bots/:botId', {
  name: 'accountDetails',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots", this.params._id);
    Meteor.subscribe("scripts");
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("botSessions", this.params.botId);
  },
  data(){ return Meteor.users.findOne(this.params._id); },
  action(){ this.render('accountPage') }
});

Router.route('/accounts/:_id', {
  name: 'accountPage',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots", this.params._id);
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("scripts");
  },
  data(){ return Meteor.users.findOne(this.params._id); },
  action(){ this.render('accountPage') }
});

Router.route('/', {
  name: 'accountsList',
  waitOn: function(){ return Meteor.subscribe("accounts"); },
  action: function(){ this.render('accountsList') }
});


Router.route('/login', "loginPage");

Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading',
  controller: 'AuthenticatedController'
});

Router.route('/network_handles/:_id', {
  waitOn(){
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("rooms", this.params._id);
  },
  data(){ return CustomerAccounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('networkHandlePage') }
});

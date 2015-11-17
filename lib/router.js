
Router.route('/number_porting_requests', {
  name: 'numberPortingRequestList',
  waitOn(){ Meteor.subscribe("number_porting_requests") },
  action(){ this.render('numberPortingRequestList') }
});

Router.route('/number_porting_requests/new', {
  name: 'numberPortingRequestNew',
  action(){ this.render('numberPortingRequestNew') }
});


Router.route('/number_porting_requests/:_id/edit', {
  name: 'numberPortingRequestEdit',
  layoutTemplate: 'noAuthLayout',
  waitOn(){
    Meteor.subscribe("number_porting_request", this.params._id);
  },
  data(){ return NumberPortingRequests.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('numberPortingRequestEdit') },
  controller: 'UnauthenticatedController'
});


Router.route('/number_porting_requests/:_id', {
  name: 'numberPortingRequestShow',
  layoutTemplate: 'noAuthLayout',
  waitOn(){
    Meteor.subscribe("number_porting_request", this.params._id);
  },
  data(){ return NumberPortingRequests.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('numberPortingRequestShow') },
  controller: 'UnauthenticatedController'
});

Router.route('/port_start_notifications/new', {
  name: 'portStartNotificationNew',
  action() { this.render('portStartNotificationNew'); },
  waitOn() { Meteor.subscribe('number_porting_requests_by_ids', Session.get('nprIdsToPort')); }
});

Router.route('/accounts/new', {
  name: 'accountsNew',
  action() { this.render('accountsNew'); }
});

Router.route('/accounts/:_id/bots/:botId', {
  name: 'accountDetails',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots", new Mongo.ObjectID(this.params._id));
    Meteor.subscribe("scripts");
  },
  data(){ return CustomerAccounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('accountPage') }
});

Router.route('/accounts/:_id', {
  name: 'accountPage',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots", new Mongo.ObjectID(this.params._id));
    Meteor.subscribe("scripts");
  },
  data(){ return CustomerAccounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('accountPage') }
});

Router.route('/', {
  name: 'accountsList',
  waitOn: function(){ return Meteor.subscribe("accounts"); },
  data: function(){ return CustomerAccounts.find(); },
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
    Meteor.subscribe("network_handles", this.params._id);
    Meteor.subscribe("rooms", this.params._id);
  },
  data(){ return CustomerAccounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('networkHandlePage') }
});

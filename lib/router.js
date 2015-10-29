
Router.route('/number_porting_requests', {
  name: 'numberPortingRequestList',
  waitOn(){ Meteor.subscribe("number_porting_requests") },
  data(){ return NumberPortingRequests.find() },
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
  action(){ this.render('numberPortingRequestEdit') }
});



Router.route('/accounts/:_id', {
  name: 'accountPage',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("network_handles");
    Meteor.subscribe("rooms", this.params._id);
  },
  data(){ return RegisteredAccounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('accountPage') }
});

Router.route('/', {
  name: 'accountsList',
  waitOn: function(){ return Meteor.subscribe("accounts"); },
  data: function(){ return RegisteredAccounts.find(); },
  action: function(){ this.render('accountsList') }
});


Router.route('/login', "loginPage");

Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading'
});

Router.onBeforeAction(function(){
  if (!Meteor.userId()) {
    Router.go("/login");
    this.next();
  } else {
    this.next();
  }
});

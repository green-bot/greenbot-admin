Router.route('/bots/:_id/addresses/:networkHandleName', {
  name: 'networkAddressShow',
  waitOn(){ return Meteor.subscribe("bot", this.params._id); },
  data(){ return Bots.findOne(); },
  action(){ this.render('networkAddressShow') },
});


// ********** NPR *************
Router.route('/number_porting_requests', {
  name: 'numberPortingRequestList',
  waitOn(){ Meteor.subscribe("numberPortingRequests") },
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
// ------------ END --------------

Router.route('/port_start_notifications/new', {
  name: 'portStartNotificationNew',
  action() { this.render('portStartNotificationNew'); },
  waitOn() { Meteor.subscribe('numberPortingRequestsByIds', Session.get('nprIdsToPort')); }
});

// ********** Accounts ********** //
Router.route('/accounts/new', {
  name: 'accountsNew',
  action() { this.render('accountsNew'); }
});

Router.route('/bot/:botId/settings', {
  name: 'botSettings',
  waitOn(){
    Meteor.subscribe("bots");
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("botSessions", this.params.botId);
  },
  data(){ return Bots.findOne(this.params.botId);},
  action(){ this.render('botSettings') }
});

Router.route('/bot/:botId', {
  name: 'bot',
  waitOn(){
    Meteor.subscribe("bots");
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("botSessions", this.params.botId);
  },
  data(){ return Bots.findOne(this.params.botId);},
  action(){ this.render('bot') }
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
// ---------- END -------------

Router.route('/conversations/:_id', {
  waitOn(){ Meteor.subscribe("session", this.params._id) },
  data(){ return Sessions.findOne() },
  action(){ this.render('conversationDetails') }
})

Router.route('/network_handles/:accountId', {
  waitOn(){
    Meteor.subscribe("networkHandles", this.params.accountId);
    Meteor.subscribe("rooms", this.params.accountId);
  },
  data(){ return CustomerAccounts.findOne(new Mongo.ObjectID(this.params.accountId)); },
  action(){ this.render('networkHandlePage') }
});

Router.route('/', {
  name: 'home',
  action: function(){ this.redirect('/dashboard') }
})


Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading',
  controller: 'AuthenticatedController'
});

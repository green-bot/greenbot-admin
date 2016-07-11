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
  data(){ return NumberPortingRequests.findOne(this.params._id); },
  action(){ this.render('numberPortingRequestEdit') },
  controller: 'UnauthenticatedController'
});

Router.route('/number_porting_requests/:_id', {
  name: 'numberPortingRequestShow',
  layoutTemplate: 'noAuthLayout',
  waitOn(){
    Meteor.subscribe("numberPortingRequest", this.params._id);
  },
  data(){ return NumberPortingRequests.findOne(this.params._id); },
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
  layoutTemplate: 'libraryLayout',
  name: 'accountsNew',
  action() { this.render('accountsNew'); }
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
  data(){ return CustomerAccounts.findOne(this.params.accountId); },
  action(){ this.render('networkHandlePage') }
});

Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading',
  controller: 'AuthenticatedController'
});

Router.route('/accountsList', {
  name: 'accountsList',
  action: function () { this.render('accountsList') },
  layoutTemplate: 'libraryLayout',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots", this.params._id);
    Meteor.subscribe("networkHandles", this.params._id);
    Meteor.subscribe("scripts");
  },
  data(){ return Meteor.users.find(); }
})


Router.route('/bots-list', {
  name: 'botsList',
  action: function () { this.render('botsList') },
  waitOn(){
    //Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("bots");
  },
  data(){ return Bots.find(); }
})



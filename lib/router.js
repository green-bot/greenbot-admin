Router.route('/bots/:_id/addresses/:networkHandleName', {
  name: 'networkAddressShow',
  waitOn(){ return Meteor.subscribe("bot", this.params._id); },
  data() { return Bots.findOne(); },
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
});

Router.route('/', {
  waitOn: function () {
    return Meteor.subscribe('bots')
  },
  template: 'home',
  action: function () {
    this.render()
  }
})

Router.route('/script', {
  name: 'script',
  action: function() {
    return this.render('script');
  },
  waitOn: function() {
  }
});


Router.route('/bot/:botId', {
  name: 'bot',
  layoutTemplate: 'listLayout',
  action: function () { this.render('bot') } ,
  waitOn(){
    Meteor.subscribe("bots");
    Meteor.subscribe("scripts");
    Meteor.subscribe("sessions", this.params.botId);
  },
  data(){ return Bots.findOne(this.params.botId); }
});

Router.route('/bot/:botId/:section', {
  name: 'data',
  layoutTemplate: 'listLayout',
  action: function () { 
    var section = this.params.section
    capitalizedSection = section.charAt(0).toUpperCase()  + section.slice(1) 
    this.render('bot' + capitalizedSection) 
  },
  waitOn(){
    Meteor.subscribe("bots");

    switch(this.params.section){
    case 'settings':
      Meteor.subscribe("networkHandles", this.params._id);
    case 'convos':
      Meteor.subscribe("sessions", this.params.botId);
    case 'networks':
      Meteor.subscribe("networks");
    case 'settings':
      Meteor.subscribe("sessions", this.params.botId);
      Meteor.subscribe("networkHandles", this.params._id);
    }
  },
  data(){ return Bots.findOne(this.params.botId); }
});

Router.route('bots/new',{
  name: 'botsNew',
  layoutTemplate: 'listLayout',
  action () { this.render('botsNew') },
  waitOn () {
    Meteor.subscribe('bots');
    Meteor.subscribe('scripts');
  },
  data () { return Scripts.find() }
});

Router.route('bots/configure/:id')

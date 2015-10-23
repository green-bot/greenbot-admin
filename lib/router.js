
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

Router.route('/accounts/:_id', {
  name: 'accountPage',
  waitOn(){
    Meteor.subscribe("account", this.params._id);
    Meteor.subscribe("dids", this.params._id);
    Meteor.subscribe("rooms", this.params._id);
  },
  data(){ return Accounts.findOne(new Mongo.ObjectID(this.params._id)); },
  action(){ this.render('accountPage') }
});

Router.route('/', {
  name: 'accountsList',
  waitOn: function(){ return Meteor.subscribe("accounts"); },
  data: function(){ return Accounts.find(); },
  action: function(){ this.render('accountsList') }
});


Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading'
});

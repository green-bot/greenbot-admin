Router.route('/number_porting_requests', {name: 'numberPortingRequestList'});

Router.route('/number_porting_requests/new', {
  name: 'numberPortingRequestNew',
  controller: 'NumberPortingRequestsController',
  action: 'new',
  where: 'client'
});



Router.route('/', {name: 'accountsList'});
Router.route('/accounts/:_id', {
  name: 'accountPage',
  data: function() { 
    return Accounts.findOne(new Mongo.ObjectID(this.params._id)); 
  }
});


Router.configure({
  layoutTemplate: 'masterLayout',
  loadingTemplate: 'loading'
});

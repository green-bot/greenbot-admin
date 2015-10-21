Router.route('/number_porting_requests', {name: 'numberPortingRequestList'});

Router.route('/number_porting_requests/new', {
  name: 'numberPortingRequestNew',
  controller: 'NumberPortingRequestsController',
  action: 'new',
  where: 'client'
});



Router.route('/', {name: 'accountsList'});



Router.configure({
  layoutTemplate: 'masterLayout'
});

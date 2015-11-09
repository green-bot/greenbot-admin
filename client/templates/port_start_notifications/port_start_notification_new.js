Template.portStartNotificationNew.helpers({
  'numberPortingRequests' : (tmpl) => {
    return NumberPortingRequests.find().fetch();
  }
});

Template.portStartNotificationNew.events({
  'click #start-porting' : (e, tmpl) => {
    Meteor.call('startPorting', Session.get('nprIdsToPort'));
    Router.go('numberPortingRequestList', null, {query: 'current_tab=started'} );
  }
});

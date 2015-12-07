Template.numberPortingRequestNew.events({

  'submit form' : (e, tmpl) => {
    e.preventDefault();

    numberPortingRequest = form2js(e.target);
    numberPortingRequest.accountId = new Mongo.ObjectID( Router.current().params.query.account_id );

    var id = NumberPortingRequests.insert(numberPortingRequest);
    numberPortingRequest._id = id;
    Router.go('numberPortingRequestList', null, {query: 'current_tab=new'} );
    Meteor.call('sendConfirmLoaEmail', numberPortingRequest);
  }
});


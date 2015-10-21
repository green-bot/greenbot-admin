Template.numberPortingRequestNew.events({

  'submit form' : (e, tmpl) => {
    e.preventDefault();

    numberPortingRequest = form2js(e.target);
    numberPortingRequest.createdAt = new Date();

    NumberPortingRequests.insert(numberPortingRequest);
    Router.go("numberPortingRequestList")
  }
});


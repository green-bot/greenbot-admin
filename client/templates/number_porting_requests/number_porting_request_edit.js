Template.numberPortingRequestEdit.events({

  'submit form' : (e, tmpl) => {
    e.preventDefault();
    numberPortingRequestId = new Mongo.ObjectID( Router.current().params._id);

    numberPortingRequest = NumberPortingRequests.findOne( numberPortingRequestId );
    npr_params = form2js(e.target);
    npr_params.loaConfirmedAt = new Date();
    NumberPortingRequests.update(numberPortingRequestId, { $set: npr_params });

    Router.go("numberPortingRequestShow", { _id: numberPortingRequestId.toHexString() });
  }
});


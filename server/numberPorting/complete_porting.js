Meteor.methods({
  completePorting: function (numberPortingRequestIds) {
    NumberPortingRequests.update({ _id: {$in: numberPortingRequestIds}}, { $set: {portingCompletedAt: new Date()} }, {multi: true});

    NumberPortingRequests.find({_id: {$in: numberPortingRequestIds}}).forEach(function(e){
      NetworkHandles.insert({allocated: true, handle: e.number, numberPortingRequestId: e._id, accountId: e.accountId, network: 'tsg'});
    });
  }
});

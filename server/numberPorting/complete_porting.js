Meteor.methods({
  completePorting: function (numberPortingRequestIdStrings) {
    var ids = numberPortingRequestIdStrings.map(function(idString) {
      return new Mongo.ObjectID(idString);
    });
    NumberPortingRequests.update({ _id: {$in: ids}}, { $set: {portingCompletedAt: new Date()} }, {multi: true});

    NumberPortingRequests.find({_id: {$in: ids}}).forEach(function(e){
      NetworkHandles.insert({allocated: true, handle: e.number, numberPortingRequestId: e._id, accountId: e.accountId, network: 'tsg'});
    });
  }
});

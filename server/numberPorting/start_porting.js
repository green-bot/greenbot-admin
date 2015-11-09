Meteor.methods({
  startPorting: function (numberPortingRequestIdStrings) {
    var ids = numberPortingRequestIdStrings.map(function(idString) {
      return new Mongo.ObjectID(idString);
    });
    NumberPortingRequests.update({ _id: {$in: ids}}, { $set: {portingStartedAt: new Date()} }, {multi: true});
  }
});

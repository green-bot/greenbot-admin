Meteor.methods({
  startPorting: function (numberPortingRequestIds) {
    NumberPortingRequests.update({ _id: {$in: numberPortingRequestIds}}, { $set: {portingStartedAt: new Date()} }, {multi: true});
  }
});

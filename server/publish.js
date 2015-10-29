Meteor.publish('accounts', function(){
  return RegisteredAccounts.find({}, {order: {createdAt: -1}});
});

Meteor.publish('account', function(id){
  return RegisteredAccounts.find({_id: new Mongo.ObjectID(id) });
});

Meteor.publish('network_handles', function(){
  return NetworkHandles.find();
});

Meteor.publish('rooms', function(accountId){
  return Rooms.find({userId: new Mongo.ObjectID(accountId) });
});

Meteor.publish('number_porting_requests', function(accountId){
  return NumberPortingRequests.find({});
});

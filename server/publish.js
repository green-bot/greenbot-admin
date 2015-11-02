Meteor.publish('accounts', function(){
  return Accounts.find({}, {order: {createdAt: -1}});
});

Meteor.publish('account', function(id){
  return Accounts.find({_id: new Mongo.ObjectID(id) });
});

Meteor.publish('network_handles', function(){
  return NetworkHandles.find();
});

Meteor.publish('rooms', function(accountId){
  return Rooms.find({userId: new Mongo.ObjectID(accountId) });
});

Meteor.publish('number_porting_requests', function(){
  return NumberPortingRequests.find({});
});

Meteor.publish('number_porting_request', function(id){
  return NumberPortingRequests.find({_id: new Mongo.ObjectID(id) });
});

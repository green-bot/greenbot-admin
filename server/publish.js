Meteor.publish('accounts', function(){
  return Accounts.find({}, {order: {createdAt: -1}});
});

Meteor.publish('account', function(id){
  return Accounts.find({_id: new Mongo.ObjectID(id) });
});

Meteor.publish('dids', function(accountId){
  return Dids.find({userId: new Mongo.ObjectID(accountId) });
});

Meteor.publish('rooms', function(accountId){
  return Rooms.find({userId: new Mongo.ObjectID(accountId) });
});

Meteor.publish('number_porting_requests', function(accountId){
  return NumberPortingRequests.find({});
});

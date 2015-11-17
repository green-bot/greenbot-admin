var publishIfSignedIn = function(collection, func) {
  Meteor.publish(collection, function() {
    var self = this;
    if(this.userId) {
      return func.apply(self, arguments);
    }
  });
};

publishIfSignedIn('accounts', function(){
  return CustomerAccounts.find({}, {order: {createdAt: -1}});
});

publishIfSignedIn('account', function(id){
  return CustomerAccounts.find({_id: new Mongo.ObjectID(id) });
});

publishIfSignedIn('network_handles', function(){
  return NetworkHandles.find();
});

publishIfSignedIn('bots', function(accountId){
  return Bots.find({accountId: accountId});
});

publishIfSignedIn('scripts', function(){
  return Scripts.find();
});

publishIfSignedIn('rooms', function(accountId){
    return Rooms.find({userId: new Mongo.ObjectID(accountId) });
});

publishIfSignedIn('number_porting_requests', function(){
  return NumberPortingRequests.find({});
});

publishIfSignedIn('number_porting_requests_by_ids', function(ids){
  objectIds = _.map(ids, function(id){ return new Mongo.ObjectID(id); });
  return NumberPortingRequests.find({_id: { $in: objectIds }});
});

publishIfSignedIn('number_porting_request', function(id){
  return NumberPortingRequests.find({_id: new Mongo.ObjectID(id) });
});

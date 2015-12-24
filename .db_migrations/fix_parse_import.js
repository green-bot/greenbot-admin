var insertAtRoot = function(collection){
  brokenTopLevelDoc = collection.findOne({results: {$exists: true}});
  if(!brokenTopLevelDoc) return;

  var items = brokenTopLevelDoc.results;
  items.forEach(function(item){
    collection.insert( item );
  });
  collection.remove(brokenTopLevelDoc._id);
}

//@tom 29 rooms couldn't find their corresponding DID what should we do with those?
//db.Rooms.count({didId: {$exists: false}})  
var fixRoomDidReferences = function(){
  db.Rooms.find({didId: {$exists: false}}).forEach(function(room){
    var did = db.Dids.findOne({did: room.name});
    if(!did) return;
    db.Rooms.update(room, {$set: {didId: did._id}});
  });
}

var fixDidUserReference = function(){
  db.Dids.find({userId: {$exists: false}}).forEach(function(did){
    var room = db.Rooms.findOne({ didId: did._id  });
    if(!room) return;
    var userId = room.userId;
    db.Dids.update(did, {$set: {userId: userId}});
  });

  db.Dids.find({user: {$exists: true}, userId: {$exists: false}}).forEach(function(did){
    var user = db.Users.findOne({objectId: did.user.objectId});
    if(!user) return;
    db.Dids.update(did, {$set: {userId: user._id}});
  });
}

var fixRoomUserReferences = function(){
  db.Rooms.find({userId: {$exists: false}}).forEach(function(room){
    var user = db.Users.findOne({objectId: room.user.objectId});
    if(user) db.Rooms.update(room, {$set: {userId: user._id}});
  });
}


//@tom ghostofbasho@gmail.com has 30 room but in rails it has 23.  (╯°□°）╯︵ ┻━┻)      ¯\_(ツ)_/¯
var addRoomsCountToUsers = function(){
  db.Users.find().forEach(function(user){
    var roomsCount = db.Rooms.count({userId: user._id});
    db.Users.update(user, {$set: {roomsCount: roomsCount} });
  });
}

var addAccountReferenceToNetworkHandles = function(){
  db.NetworkHandles.find().forEach(function(nh){
    var room = db.Rooms.findOne({didId: nh._id});
    if(room) db.NetworkHandles.update(nh, {$set: {accountId: room.userId}});
  });
}

var renameCustomersUsernameToEmail = function(){
  db.Customers.update({}, {$rename: { "username" : "email" }}, {multi: true});
};

var renameNetworkHandlesDidToHandle = function() {
  db.NetworkHandles.update({}, {$rename: { "did" : "handle" }}, {multi: true});
};

var renameRoomsDidIdToNetworkHandleId = function() {
  db.Rooms.update({}, {$rename: {"didId": "networkHandleId"}}, {multi: true});
};

var mergeCustomersAndUsers = function() {
  // TODO: check this on a fresh app setup. If there is no users collection yet, it's going to be created during first user insert,
  // but in that case we could potentially miss indexation on this collection. (Meteor-accounts applys index on email field when it creates this table)
  db.Customers.find().forEach(function(customer){
    if( db.users.findOne({"emails.address" : customer.email}) ) return;
    db.users.insert({
      "services" : {
        "password" : {
          "bcrypt" : customer.bcryptPassword
        }
      },
      "emails" : [
        {
          "address" : customer.email,
          "verified" : false
        }
      ],
      "profile": {resellerId: customer.reseller_id, roomsCount: customer.roomsCount }
    });
  })
}

var markAdmins = function(){
  db.users.update({"profile" : {$exists: false}}, { $set: { "isAdmin" : true }}, {multi: true})
}

var reassociateNetworkHandlesWithUsers = function() {
  var handles = db.NetworkHandles.find({ accountId: {$exists: true} });
  handles.forEach(function(handle) {
    var customer = db.Customers.findOne({ _id: handle.accountId });
    if(customer) {
      var customerEmail = customer.email;
      var user = db.users.findOne({"emails.address" : customerEmail });
      db.NetworkHandles.update({ _id: handle._id }, { $set: { accountId: user._id }});
    }
  });
};


var migrate = function(){
  var collections = [db.Users, db.Networks, db.Rooms, db.Dids, db.Scripts, db.Sessions];
  collections.forEach(insertAtRoot);
  fixRoomDidReferences();
  fixRoomUserReferences();
  addRoomsCountToUsers();
  db.Dids.renameCollection("NetworkHandles");
  addAccountReferenceToNetworkHandles();
  db.Users.renameCollection("Customers");
  renameCustomersUsernameToEmail();
  renameNetworkHandlesDidToHandle();
  renameRoomsDidIdToNetworkHandleId();
  mergeCustomersAndUsers();
  markAdmins();
  reassociateNetworkHandlesWithUsers();
}

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

//var fixReference = function(fixerupperCollection, refCollection, legacyFkPath, legacyPkPath, newFkPath){
  //fixerupperCollection.find().forEach(function(doc){
    //var legacyFkValue = eval("doc." + legacyFkPath);
    
    //var queryObject = {};
    //queryObject[legacyPkPath] = legacyFkValue;
    //var refDoc = refCollection.findOne(queryObject);

    //if(!refDoc) return;
    //fixerupperCollection.update(doc, {$set: {newFkPath: refDoc._id}});
  //});
//}


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

var migrate = function(){
  var collections = [db.Users, db.Networks, db.Rooms, db.Dids, db.Scripts];
  collections.forEach(insertAtRoot);
  fixRoomDidReferences();
  fixRoomUserReferences();
  addRoomsCountToUsers();
  db.Dids.renameCollection("NetworkHandles");
  addAccountReferenceToNetworkHandles();
  db.Users.renameCollection("Customers");
  renameCustomersUsernameToEmail();
  //--optionally--
  //rename did field in NetworkHandles to 'handle'
  //rename did_id fields (foreign keys) to network_handle_id
}

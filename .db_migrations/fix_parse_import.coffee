require('coffee-script')
Random = require('meteor-random')
MongoClient = require('mongodb').MongoClient
Proxy = require('harmony-proxy')
CONNECTION_STRING = process.env.MONGO_URL or 'mongodb://localhost:27017/greenbot'

MongoClient.connect(CONNECTION_STRING).then (dbCon) ->
  handle = get: (something, name) ->
    dbCon.collection name

  db = new Proxy({}, handle)

  insertAtRoot = (collection) ->
    collection.findOne results: $exists: true, (err, brokenTopLevelDoc)->
      return if !brokenTopLevelDoc
      items = brokenTopLevelDoc.results
      items.forEach (item) ->
        item._id = Random.id()
        collection.insert item
      collection.remove brokenTopLevelDoc._id

  #@tom 29 rooms couldn't find their corresponding DID what should we do with those?
  #db.Rooms.count({didId: {$exists: false}})  

  fixRoomDidReferences = ->
    db.Rooms.find didId: $exists: false, (err, rooms)->
      console.log "found ROOMS"
      console.log "Error: #{err}"
      rooms.forEach (room) ->
        db.Dids.findOne did: room.name, (err, did)->
          return if !did
          db.Rooms.update room, $set: didId: did._id

  fixDidUserReference = ->
    console.log "fix did user ref"
    db.Dids.find userId: $exists: false, (err,dids)->
      dids.forEach (did) ->
        db.Rooms.findOne didId: did._id, (err, room)->
          return if !room
          userId = room.userId
          db.Dids.update did, $set: userId: userId

    db.Dids.find  user: $exists: true,userId: $exists: false, (err, dids)->
      dids.forEach (did) ->
        db._User.findOne objectId: did.user.objectId, (err, user)->
          return if !user
          db.Dids.update did, $set: userId: user._id

  fixRoomUserReferences = ->
    console.log "fix room user ref"
    db.Rooms.find userId: $exists: false, (err, rooms)->
      rooms.forEach (room) ->
        db._User.findOne objectId: room.user.objectId, (err, user)->
          if user
            db.Rooms.update room, $set: userId: user._id

  #@tom ghostofbasho@gmail.com has 30 room but in rails it has 23.  (╯°□°）╯︵ ┻━┻)      ¯\_(ツ)_/¯

  addRoomsCountToUsers = ->
    console.log "add rooms count to users"
    db._User.find (err, users)->
      users.forEach (user) ->
        roomsCount = db.Rooms.count(userId: user._id)
        db._User.update user, $set: roomsCount: roomsCount

  addAccountReferenceToNetworkHandles = ->
    console.log "add account ref to nh"
    db.NetworkHandles.find (networkHandles)->
      networkHandles.forEach (nh) ->
        db.Rooms.findOne didId: nh._id, (err, room)->
          if room
            db.NetworkHandles.update nh, $set: accountId: room.userId

  renameCustomersUsernameToEmail = ->
    console.log "rename customers username to email"
    db.Customers.update {}, { $rename: 'username': 'email' }, multi: true

  renameNetworkHandlesDidToHandle = ->
    console.log "rename customers username to email"
    db.NetworkHandles.update {}, { $rename: 'did': 'handle' }, multi: true

  renameRoomsDidIdToNetworkHandleId = ->
    console.log "rename rooms did to nhid"
    db.Rooms.update {}, { $rename: 'didId': 'networkHandleId' }, multi: true

  mergeCustomersAndUsers = ->
    console.log "merge customers and users"
    # TODO: check this on a fresh app setup. If there is no users collection yet, it's going to be created during first user insert,
    # but in that case we could potentially miss indexation on this collection. (Meteor-accounts applys index on email field when it creates this table)
    db.Customers.find (err, customers)->
      customers.forEach (customer) ->
        db.users.findOne 'emails.address': customer.email, (err, user)->
          return if user
          db.users.insert
            '_id': Random.id()
            'services': 'password': 'bcrypt': customer.bcryptPassword
            'emails': [ {
              'address': customer.email
              'verified': false
            } ]
            'profile':
              resellerId: customer.reseller_id
              roomsCount: customer.roomsCount

  markAdmins = ->
    console.log "mark admins"
    db.users.update { 'profile': $exists: false }, { $set: 'isAdmin': true }, multi: true

  reassociateNetworkHandlesWithUsers = ->
    console.log "reassiciate nh with users"
    db.NetworkHandles.find accountId: $exists: true, (err, handles)->
    handles.forEach (handle) ->
      db.Customers.findOne _id: handle.accountId, (err, customer)->
        if customer
          customerEmail = customer.email
          db.users.findOne 'emails.address': customerEmail, (err, user)->
            db.NetworkHandles.update { _id: handle._id }, $set: accountId: user._id

  migrate = ->
    collections = [
      db._User
      db.Networks
      db.Rooms
      db.Dids
      db.Scripts
      db.Sessions
    ]
    #var collections = ['_User', 'Networks', 'Rooms', 'Dids', 'Scripts', 'Sessions'];
    collections.forEach insertAtRoot
    fixRoomDidReferences()
    fixRoomUserReferences()
    addRoomsCountToUsers()
    console.log "before renaming nh collection..."
    db.Dids.renameCollection 'NetworkHandles'
    addAccountReferenceToNetworkHandles()
    db._User.renameCollection 'Customers'
    renameCustomersUsernameToEmail()
    renameNetworkHandlesDidToHandle()
    renameRoomsDidIdToNetworkHandleId()
    mergeCustomersAndUsers()
    markAdmins()
    reassociateNetworkHandlesWithUsers()

  migrate()

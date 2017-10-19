Meteor.methods
  'addUser' : (email, password) ->
    console.log "CREATING NEW USERR!!!"
    newUserId = Accounts.createUser email: email, password: password
    Accounts.onCreateUser options, user ->
     user.accountId = Object.assign accountId: Accounts._hashPassword(Random.id())
     console.log "attempting to add============", user
     user 
    console.log("Created new user (#{newUserId}): #{email}")

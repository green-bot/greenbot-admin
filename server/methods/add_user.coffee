Meteor.methods
  'addUser' : (email, password) ->
    newUserId = Accounts.createUser email: email, password: password
    console.log("Created new user (#{newUserId}): #{email}")

Meteor.methods({
  checkIsAdmin: function (email) {
    user = Meteor.users.findOne({ "emails.address" : email, "isAdmin" : true });
    if(!user) throw new Meteor.Error("AuthError", "Authentication failed", "");
  }
})

Template.accountsList.helpers({
  accounts : () => {
    return Meteor.users.find({ isAdmin: { $exists: false } });
  },
  getEmail : (account) => {
    return account.emails[0].address;
  }
})

Template.accountsList.helpers({
  accounts : () => {
    return Meteor.users.find({ isAdmin: { $exists: false }}, {sort: {"emails.0.address": 1}});
  },
  getEmail : (account) => {
    return account.emails[0].address;
  }
})

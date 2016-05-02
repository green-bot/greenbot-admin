Template.accountsList.helpers({
  accounts: () => {
    return Meteor.users.find({ isAdmin: { $exists: false }}, {sort: {"emails.0.address": 1}});
  },
  getEmail: (account) => {
    console.log(account)
    console.log(account.emails[0].address)
    return account.emails[0].address
  }
})

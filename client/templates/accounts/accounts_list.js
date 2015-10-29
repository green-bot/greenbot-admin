Template.accountsList.helpers({
  accounts : () => {
    return RegisteredAccounts.find();
  }
})

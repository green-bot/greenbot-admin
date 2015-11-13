Template.accountsList.helpers({
  accounts : () => {
    return CustomerAccounts.find();
  }
})

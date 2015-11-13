Template.accountsNew.events({
  'submit form' : (e, tmpl) => {
    e.preventDefault();

    var accountParams = form2js(e.target);
    accountParams.createdAt = new Date();

    CustomerAccounts.insert(accountParams);
    Router.go('accountsList');
  }
});


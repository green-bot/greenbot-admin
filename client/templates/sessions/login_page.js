
Template.loginPage.helpers({
  'errorMessageShown' : () => {
    return Session.get('errorMessageShown');
  }
});

Template.loginPage.events({
  'submit #login-form' : function(e, t){
    e.preventDefault();

    Session.set('errorMessageShown', false);

    var email    = e.target["email"].value;
    var password = e.target["password"].value;

    Meteor.call("checkIsAdmin", email, function(err){
      if (err)
        Session.set('errorMessageShown', true);
      else{
        Meteor.loginWithPassword(email, password, function(err2){
          if (err2)
            Session.set('errorMessageShown', true);
          else
            Router.go("/")
        });
      
      }
    });
  },

  'click .close' : () => {
    Session.set('errorMessageShown', false);
  }
})

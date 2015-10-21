NumberPortingRequestsController = RouteController.extend({
  layoutTemplate: "MasterLayout",
  
  subscriptions: function() {
    //this.subscribe("lists");
    //this.subscribe("cards");
    //this.subscribe("account_users");
  },

  waitOn: function () {
  },
  
  new: function () {
    this.render('numberPortingRequestNew');
  }

});


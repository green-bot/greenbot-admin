AuthenticatedController = RouteController.extend({
  onBeforeAction(){
    if (!Meteor.userId()) {
      Router.go("/login");
    }
    this.next();
  }
});

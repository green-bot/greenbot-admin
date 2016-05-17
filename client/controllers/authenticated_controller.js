AuthenticatedController = RouteController.extend({
  onBeforeAction(){
    if (!Meteor.userId()) {
      Router.go("/sign-in");
      this.next();
    } else {
      this.next();
    }
  }
});

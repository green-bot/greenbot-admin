Template.registerHelper("activeNavLink", function(...routes) {
  var curRoute = Router.current().route.getName();
  return _.contains(routes, curRoute) ? 'active' : '';
});

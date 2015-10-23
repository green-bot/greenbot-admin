Template.registerHelper("activeNavLink", function(...routes) {
  var curRoute = Router.current().route.getName();
  return _.contains(routes, curRoute) ? 'active' : '';
});

Template.registerHelper("activeTab", function(tab, defaultTab='default') {
  var curTab = Router.current().params.query.current_tab || defaultTab;
  return tab === curTab ? 'active' : '';
});

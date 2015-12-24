Template.registerHelper("activeNavLink", function(...routes) {
  var curRoute = Router.current().route
  if(curRoute){
    var curRouteName = curRoute.getName();
    return _.contains(routes, curRouteName) ? 'active' : '';
  }
});

Template.registerHelper("activeTab", function(tab, defaultTab='default') {
  var curTab = Router.current().params.query.current_tab || defaultTab;
  return tab === curTab ? 'active' : '';
});

Template.registerHelper("parseJson", function(jsonString) {
  return JSON.parse(jsonString);
});

Template.registerHelper("readSession", function(key) {
  return Session.get(key);
});

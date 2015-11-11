Template.numberPortingRequestList.events({

});

var currentTab = function() {
  return Router.current().params.query.current_tab || "ready";
}

Template.numberPortingRequestList.helpers({
  'currentTabTemplate' : function() {
    var tab = currentTab();
    var capitalized = tab[0].toUpperCase() + tab.substr(1, tab.length - 1);
    return "numberPortingRequest" + capitalized + "Tab";
  },

  'addressLine' : function(tmpl){
    return [this.serviceLocationAddress, this.suiteNum, this.city, this.state, this.zip].join(", ");
  },
});

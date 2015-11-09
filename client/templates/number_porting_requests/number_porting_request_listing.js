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

  'numberPortingRequests' : function(tmpl){
    var tab = currentTab();

    switch(tab){
    case 'new':
      return NumberPortingRequests.find({ $or: [{ ownershipConfirmedAt: null }, {loaConfirmedAt: null}] }); 
    case 'ready':
      return NumberPortingRequests.find({ ownershipConfirmedAt: { $not: null }, portingStartedAt: null }); 
    case 'started':
      return NumberPortingRequests.find({ portingStartedAt: { $not: null }, portingCompletedAt: null }); 
    case 'completed':
      return NumberPortingRequests.find({ portingCompletedAt: { $not: null }}); 
    }
  },

  'addressLine' : function(tmpl){
    return [this.serviceLocationAddress, this.suiteNum, this.city, this.state, this.zip].join(", ");
  },
});

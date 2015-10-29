Template.numberPortingRequestList.events({

});

Template.numberPortingRequestList.helpers({
  'numberPortingRequests' : function(tmpl){
    current_tab = Router.current().params.query.current_tab || "ready";

    switch(current_tab){
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
  }

});

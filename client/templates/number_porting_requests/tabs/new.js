Template.numberPortingRequestNewTab.events({ });

Template.numberPortingRequestNewTab.helpers({
  'numberPortingRequests' : function(tmpl) {
    return NumberPortingRequests.find({ $or: [{ ownershipConfirmedAt: null }, {loaConfirmedAt: null}] }); 
  }
});

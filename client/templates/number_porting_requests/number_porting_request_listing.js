Template.numberPortingRequestList.events({

});


//scope :new_requests, -> {where("ownership_confirmed_at is NULL OR loa_confirmed_at is NULL")}
//scope :ready_requests, -> {where.not(ownership_confirmed_at: nil).where(porting_started_at: nil)}
//scope :started_requests, -> {where(porting_completed_at: nil).where.not(porting_started_at: nil)}
//scope :completed_requests, -> {where.not(porting_completed_at: nil)}


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
    return [this.serviceLocationAddress, this.suiteNum, this.city, this.state, this.zip].join(", ")
  }

});

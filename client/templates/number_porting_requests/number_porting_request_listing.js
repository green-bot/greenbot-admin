Template.numberPortingRequestList.events({

});


Template.numberPortingRequestList.helpers({
  'numberPortingRequests' : function(tmpl){
    return NumberPortingRequests.find();
  },

  'addressLine' : function(tmpl){
    return [this.serviceLocationAddress, this.suiteNum, this.city, this.state, this.zip].join(", ")
  }

});

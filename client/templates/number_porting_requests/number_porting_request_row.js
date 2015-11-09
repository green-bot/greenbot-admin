Template.numberPortingRequestRow.events({
});

Template.numberPortingRequestRow.helpers({
  'addressLine' : function(tmpl){
    return [this.serviceLocationAddress, this.suiteNum, this.city, this.state, this.zip].join(", ");
  },
  'isRequestChecked' : function(tmpl){
    return Session.get(this._id._str + '-checked');
  }
});

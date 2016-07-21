var _networkAddress = function(){
  var address = _.find(this.addresses, function(address){
    return address.networkHandleName == Router.current().params.networkHandleName && address.keyword == Router.current().params.keyword;
  });
  return address;
}

Template.networkAddressShow.helpers({
  networkAddress(){
    return _networkAddress();
  }
});

Template.networkAddressShow.events({
  'submit form[name="network-handle"]' : function(e, tmpl){
    e.preventDefault();

    var address = _networkAddress();
    var updatedAddress = _.clone(address);
    updatedAddress.ownerHandles = e.target.ownerHandles.value.split(",");
    debugger;

    Meteor.call('updateNetworkAddress', botId, updatedAddress, function(err, res){
      if (!err){
        toastr.success('Saved!');
      }
    });
  }
});

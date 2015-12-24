var _networkAddress = function(){
  var address = _.find(this.addresses, function(address){
    return address.networkHandleName == Router.current().params.networkHandleName && address.keyword == Router.current().params.keyword;
  });
  return address;
}

Template.networkAddressShow.helpers({
  networkAddress() {
    return _networkAddress();
  }
});

Template.networkAddressShow.events({
  'submit form[name="network-handle"]' : function(e, tmpl){
    e.preventDefault();

    var address = _networkAddress();
    var updatedAddress = _.clone(address);
    updatedAddress.ownerHandles = e.target.ownerHandles.value.split(",");
    debugger
    Bots.update({_id: botId, addresses: address}, {$set: {"addresses.$": updatedAddress}});
  }
});


Template.networkAddressShow.onRendered(function(){
  // we use the same initialization code several times, need to move it into one place that can be shared
  // client/templates/accounts/_bot_details.js
  $('input[name="ownerHandles"]').selectize({
    delimiter: ',',
    persist: false,
    create: function(input) {
      return {
        value: input,
        text: input
      }
    }
  });
});

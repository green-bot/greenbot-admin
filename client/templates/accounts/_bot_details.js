Template.botDetails.helpers({
  script() {
    return Scripts.findOne(this.scriptId);
  },

  networkHandles() {
    return NetworkHandles.find();
  }

});

Template.botDetails.events({
  'submit form#new-bot-address-form' : (e, tmpl) => {
    e.preventDefault();

    var params = form2js(e.target);
    params.networkHandleId = new Mongo.ObjectID( params.networkHandleId);
    params.networkHandleName = NetworkHandles.findOne(params.networkHandleId).name();
    params.ownerHandles = [];

    var botId = Router.current().params.botId;
    Bots.update({_id: botId}, {$push: {addresses: params}});
    $('.modal').modal('hide');
  },

  'submit form[name="network-address"]' : function(e, tmpl){
    e.preventDefault();

    var params = form2js(e.target);
    params.keywords = params.keywords.split(",")
    var botId = Router.current().params.botId;
    Bots.update({_id: botId}, {$set: params});

  }
});

Template.botDetails.onRendered(function(){
  // we use the same initialization code several times, need to move it into one place that can be shared
  // client/templates/networkAddresses/networkAddressShow.js
  $('input[name="keywords"]').selectize({
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

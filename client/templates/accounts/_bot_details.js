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
    params.ownerHandles = params.ownerHandles.split(",");

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

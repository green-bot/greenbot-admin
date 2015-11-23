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

    params = form2js(e.target);
    params.networkHandleId = new Mongo.ObjectID( params.networkHandleId);
    params.networkHandleName = NetworkHandles.find(params.networkHandleId)

    botId = Router.current().params.botId;

    Bots.update({_id: botId}, {$push: {addresses: params}});
    $('.modal').modal('hide');
  }
});

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
    params.networkHandleName = NetworkHandles.findOne(params.networkHandleId).name;

    var botId = Router.current().params.botId;

    var bot = Bots.findOne({ _id: botId });
    var script = Scripts.findOne(bot.scriptId);

    var account = Meteor.users.findOne({ _id: Router.current().params._id });

    params.settings = script.default_settings


    params.description = "";
    params.notificationEmails = account.emails[0].address;
    params.ownerCellNumbers = "";
    params.postConversationWebhook = "";


    Bots.update({_id: botId}, {$push: {addresses: params}});
    $('.modal').modal('hide');
  }
});

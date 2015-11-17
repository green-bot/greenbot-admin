Template.accountPage.helpers({
 bots: function() {
   return Bots.find(); 
  },

 scripts: function() {
   return Scripts.find(); 
  },

  activeTab: function(tab){
  },

  'selectedBot' : function() {
    var selectedBotId = Router.current().params.botId;

    if(selectedBotId)
      return Bots.findOne(selectedBotId);
  },
});

Template.accountPage.events({
  'submit form#new-bot-form' : (e, tmpl) => {
    e.preventDefault();

    botParams = form2js(e.target);
    botParams.scriptId = new Mongo.ObjectID( botParams.scriptId);
    botParams.accountId = new Mongo.ObjectID( Router.current().params._id );
    Bots.insert(botParams);
    $('.modal').modal('hide');
  }
});

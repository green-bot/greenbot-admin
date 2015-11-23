Template.accountPage.helpers({
 bots() {
   return Bots.find(); 
  },

 networkHandles() {
   return NetworkHandles.find(); 
  },

 scripts() {
   return Scripts.find(); 
 },

 activeTab(tab){
 },

  selectedBot() {
    var selectedBotId = Router.current().params.botId;

    if(selectedBotId){
      bot = Bots.findOne(selectedBotId);
      return bot;
    }
  }
});

Template.accountPage.events({
  'submit form#new-bot-form' : (e, tmpl) => {
    e.preventDefault();

    botParams = form2js(e.target);
    botParams.scriptId = new Mongo.ObjectID( botParams.scriptId);
    botParams.accountId = new Mongo.ObjectID( Router.current().params._id );
    Bots.insert(botParams);
    $('.modal').modal('hide');
  },
  
  'change select#type' : (e, tmpl) => {
    $('input#name').val($(e.target).find('option:selected').text())
  }
});

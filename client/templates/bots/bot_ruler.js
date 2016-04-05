Template.botRuler.events({
  'click #delete' : function(){
    if(!confirm("Are you sure you want to delete this bot?")) return;
    Bots.remove(this._id);
    Router.go('library');
  },

  'click #browser-test-btn' : function(){
    TestBotModal.init($('#bot-test-modal'));
    TestBotModal.sendMsg("list");
    return false;
  }

})


Template.botRuler.onRendered(function(){
  jQuery.getScript("https://cdn.socket.io/socket.io-1.4.5.js")
})

Template.botRuler.helpers({
  wikiName: function(){ 
    if(Router.current() && Router.current().route)
      return Router.current().route.getName()
    else
      return "default"
  },
  currentBotId: function(){
    return Router.current().params.botId
  }
})



TestBotModal = {
  init(botTestModal) {
    var self = this;
    this.sessionId = new Date().getTime();

    botTestModal.openModal({
      complete: function() {
        self.io.disconnect()
      }
    })

    this.convosDiv = botTestModal.find('.conversation')
    this.convosDiv.html("");
    botTestModal.find('.modal-content form').off('submit').on('submit', function(){
      var input = $(this).find('input');
      self.sendMsg(input.val());
      input.val("");
      return false;
    })

    var consoleDst, consoleSrc, handleMsg, keyword, sendMsg, socketUrl;

    keyword = 'default';
    this.io = io("http://pairing.green-bot.com:3003");

    this.io.on('egress', function(msg) {
      if(self.sessionId !== msg.dst) return;

      self.drawMessage("their", msg.txt);
    });
    this.io.on('session:ended', function (sess) {
      console.log(sess)
      //this.io.disconnect()
    })
  },

  sendMsg(txt) {
    var msg = {
      dst: 'development::console',
      src: this.sessionId,
      txt: txt + "\n"
    };
    this.io.emit('ingress', msg);
    this.drawMessage("mine", msg.txt);
  },

  drawMessage(direction, txt){
    var msgHtml = $(`<div class='message-wrapper'><div class='message message-${direction}'><div class='text'>${txt}</div></div></div>`);
    var self = this;
    this.convosDiv.append(msgHtml);
    console.log(this.convosDiv.height())
    self.convosDiv.animate({scrollTop: this.convosDiv[0].scrollHeight}, '500', 'swing')
  }
}

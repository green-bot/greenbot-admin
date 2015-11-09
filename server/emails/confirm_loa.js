SSR.compileTemplate('confirmLoaBody', Assets.getText('emails/confirm_loa.html'));

Meteor.methods({
  sendConfirmLoaEmail: function (numberPortingRequest) {
    this.unblock();

    // don’t allow sending email unless the user is logged in
    if (!Meteor.user()) throw new Meteor.Error(403, "not logged in");
    var account = Accounts.findOne(numberPortingRequest.accountId);
    var host = 'http://104.131.57.1:3001';
    var editNumberPortingRequestUrl = host + Router.routes.numberPortingRequestEdit.path({_id: numberPortingRequest._id.toHexString()});

    var body_html = SSR.render("confirmLoaBody", {numberPortingRequest: numberPortingRequest, account: account, editNumberPortingRequestUrl: editNumberPortingRequestUrl});

    Email.send({
      to: account.username,
      from: "noreply@green-bot.com",
      subject: 'Please review and confirm your number porting request details for number: ' + NumberPortingRequests.number,
      html: body_html
    });
  },
});


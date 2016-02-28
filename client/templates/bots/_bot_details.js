Template.botDetails.events({
  'submit form#new-bot-address-form' : function (e, tmpl) {
    e.preventDefault()

    var botId = Router.current().params.botId
    var params = form2js(e.target)
    console.log(params)
    if (params.newNetwork && params.newNetworkHandle) {
      name = params.newNetwork + '::' + params.newNetworkHandle,
      handle = NetworkHandles.insert({
        allocated: true,
        default: true,
        network: params.newNetwork,
        handle: params.newNetworkHandle,
        name: name,
        keywords: params.keywords.split(",")
      })
      updateParams = {
        networkHandleId: new Mongo.ObjectID(handle._id),
        networkHandleName: name,
        keywords: params.keywords.split(",")
      }
    }
    else {
      updateParams = {
        networkHandleId: new Mongo.ObjectID(params.networkHandleId),
        networkHandleName: params.networkHandleId.name(),
        keywords: params.keywords.split(",")
      }
    }
    Bots.update({_id: botId}, {$push: {addresses: updateParams}})
    $('.modal').modal('hide')
  },
  'click .delete' : function(e, tmpl) {
    e.preventDefault()
    var botId = Router.current().params.botId
    var name = $(e.target).attr('name')
    console.log(e.target)
    console.log(name)
    Bots.update({_id: botId}, {$pull: {addresses: {networkHandleName: name}}})
  },

  'submit form[name="network-address"]' : function(e, tmpl){
    e.preventDefault()

    var params = form2js(e.target)
    params.keywords = params.keywords.split(",")
    var botId = Router.current().params.botId
    Bots.update({_id: botId}, {$set: params})
  }
})

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

Template.botDetails.helpers({
  script: function () {
    script = Scripts.findOne(this.scriptId)
    console.log("I gotta script")
    console.log(script)
    return script
  }
})

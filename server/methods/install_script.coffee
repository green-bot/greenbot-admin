Meteor.methods( 'installScriptViaNpm' : (packageName) ->
  gbCorePort = process.env.GREENBOT_BOT_SERVER_PORT or 3001
  Meteor.http.call 'POST', "http://localhost:#{ gbCorePort }/api/installPackage", { data: packageName: packageName }, ( error, response )->
    #Handle the error or response here.
    console.log "Requested gb core api to install a bot"
)

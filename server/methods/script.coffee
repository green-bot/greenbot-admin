Meteor.methods(
  'installScriptViaNpm' : (packageName) ->
    Meteor.http.call 'POST', gbCoreApiUrl('installPackage'), { data: packageName: packageName }, ( error, response )->
      #Handle the error or response here.
      console.log "Requested gb core api to install a bot"
  removeScript: (packageName) ->
    Scripts.remove({name: packageName})
    gbCorePort = process.env.GREENBOT_BOT_SERVER_PORT or 3001
    Meteor.http.call 'DELETE', gbCoreApiUrl('uninstallPackage'), { data: packageName: packageName }, ( error, response )->
      #Handle the error or response here.
      console.log "Requested gb core api to uninstall a script"
)

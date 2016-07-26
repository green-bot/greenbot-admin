apiUrl = (endpoint) ->
  gbCorePort = process.env.GREENBOT_BOT_SERVER_PORT or 3001
  "http://localhost:#{gbCorePort}/api/#{endpoint}"

Meteor.methods(
  killSession: (sessionId) ->
    Meteor.http.call 'DELETE', apiUrl('killSession'), { data: sessionId: sessionId }, (error, response) ->
      console.log "Requested core API to kill session #{sessionId}"
      if error?
        console.log 'Error killing session'
        console.log error
)

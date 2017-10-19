Meteor.methods(
  killSession: (sessionId) ->
    Meteor.http.call 'DELETE', gbCoreApiUrl('killSession'), { data: sessionId: sessionId }, (error, response) ->
      console.log "Requested core API to kill session #{sessionId}"
      if error?
        console.log 'Error killing session'
        console.log error
)

sanitize = (text) ->
  text.replace(/,/g,';').replace(/\n/g, ';')

Meteor.methods(
  exportSessions: (selector) ->
    sessions = Sessions.find(selector).fetch()
    extractKeys = (keys, session) ->
      keys.concat (key for own key of session.collectedData)
    allCollectedDataKeys = sessions.reduce extractKeys, []
    sessions.forEach (session) ->
      # make sure all sessions have all
      # collected data keys
      for key in allCollectedDataKeys
        newKey = "#{key}_data"
        value = session.collectedData?[key] || ''
        session[newKey] = sanitize value
      delete session.collectedData
      # replace forbidden characters in transcript
      if session.transcript?
        formatTranscript = (transcript, message) ->
          formattedMessage = " | #{message.direction}: #{sanitize message.text}"
          transcript + formattedMessage
        session.transcript = session.transcript.reduce formatTranscript, ''
      # delete empty values
      for own key, value of session
        delete session[key] unless value?

    heading = true # optional, defaults to true
    delimiter = ',' # optional, defaults to ','
    exportcsv.exportToCSV sessions, heading, delimiter
)

Template.scriptsShow.onRendered ->
  Session.set 'lastScriptViewedId', @data._id

Template.scriptsNew.onRendered ->
  $('input.package').focus()
  this.autorun =>
    return unless Session.get('newScriptName')
    if script = Scripts.findOne(name: Session.get 'newScriptName')
      Router.go "/scripts/#{script._id}"
      Session.set 'newScriptName', null
      $('.overlay').LoadingOverlay("hide")

Template.scriptsNew.events
  'submit #install-script' : (e, tmpl) ->
    console.log 'submitted'
    e.preventDefault()
    pkgName = tmpl.$('input.package').prop('value')
    console.log 'adding ' + pkgName
    Meteor.call 'installScriptViaNpm', pkgName, (err,res)->
    Session.set('newScriptName', pkgName)
    $('.overlay').LoadingOverlay("show")

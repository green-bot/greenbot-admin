Meteor.publish "scripts", ->
  return Scripts.find()

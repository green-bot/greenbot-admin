Template.accountIdNew.events
  'click .add-account-id': (e) ->
    e.preventDefault()
    Meteor.call('addAccountId')

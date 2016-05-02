Template.accountsNew.events({
  'submit form': (e, tmpl) => {
    e.preventDefault()
    var email = $("input[name='email']").val()
    var password = $("input[name='password']").val()
    Meteor.call('addUser', email, password)
    Router.go('accountsList')
  }
})

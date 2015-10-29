Template.navbar.events({
  'click .logout' : (e) => {
    e.preventDefault();
    Meteor.logout();
  }
})

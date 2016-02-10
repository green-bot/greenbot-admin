Template.accountDetails.helpers({
  networkHandles () {
    return NetworkHandles.find()
  },
  keywordJoin (keywords) {
    return keywords.join(',')
  }
})

Template.accountDetails.events({
})

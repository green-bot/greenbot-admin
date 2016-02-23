Template.accountDetails.helpers({
  networkHandles () {
    return NetworkHandles.find()
  },
  keywordJoin (keywords) {
    return keywords.join(',')
  },
  bots () {
    return Bots.find()
  }
})

Template.accountDetails.events({
})

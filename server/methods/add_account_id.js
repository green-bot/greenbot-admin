import _ from 'lodash';
import { Random } from 'meteor/random'

const addAccountIdMethod = function()  {
  if (this.userId) {
    let addedAccountIds 
    let {profile} = Meteor.user()
    
    if (!!profile) {
      let { accountIds } = profile
      console.log(accountIds)
      addedAccountIds = accountIds.concat([Random.id()])
    }
    else{
      addedAccountIds = [Random.id()]
    }
    Meteor.users.update({_id: this.userId}, {$set: {profile: {accountIds: addedAccountIds}}})
    
  }
}

Meteor.methods({
  addAccountId: addAccountIdMethod,
})

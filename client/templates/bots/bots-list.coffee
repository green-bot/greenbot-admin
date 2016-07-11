Template.botsList.helpers
  lastBotAdded: ->
    Bots.findOne({}, {sort: {createdAt:-1}})._id

Template.navItems.helpers
  #TODO change this to last viewed
	lastBotAdded: () ->
		Bots.findOne({}, {sort: {createdAt:-1}})?._id
	firstScript: () ->
		Scripts.findOne({}, {sort: {name: 1}})?._id

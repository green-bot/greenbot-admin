Template.navItems.helpers
	lastBotAdded: () ->
		Bots.findOne({}, {sort: {createdAt:-1}}) && Bots.findOne({}, {sort: {createdAt:-1}})._id
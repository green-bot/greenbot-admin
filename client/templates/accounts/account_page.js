Template.accountPage.helpers({
 dids: function() {
   return Dids.find({userId: this._id}); 
  },

 rooms: function() {
   return Rooms.find({didId: this._id}); 
  }
});

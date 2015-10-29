Template.accountPage.helpers({
 networkHandles: function() {
   return NetworkHandles.find({accountId: this._id}); 
  },

 rooms: function() {
   return Rooms.find({didId: this._id}); 
  }
});

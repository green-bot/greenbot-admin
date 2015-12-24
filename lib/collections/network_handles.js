NetworkHandles = new Mongo.Collection('NetworkHandles'); 

NetworkHandles.helpers({
  name() {
    return this.handle + '@' + this.network;
  }
})

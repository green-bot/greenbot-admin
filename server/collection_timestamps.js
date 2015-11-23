Mongo.Collection.getAll().forEach(function(collection){

  collection.instance.before.insert(function (userId, doc) {
    doc.createdAt = new Date();
  });

  collection.instance.before.update(function (userId, doc, fieldNames, modifier, options) {
    if(!modifier.$set)
      modifier.$set = {};

    modifier.$set.updatedAt = new Date();
  });

});

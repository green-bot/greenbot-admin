Template.numberPortingRequestCompletedTab.events({ });

Template.numberPortingRequestCompletedTab.helpers({
  'numberPortingRequests' : function(tmpl) {
    return NumberPortingRequests.find({ portingCompletedAt: { $not: null }}); 
  }
});

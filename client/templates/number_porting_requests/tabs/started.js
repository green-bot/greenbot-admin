Template.numberPortingRequestStartedTab.events({
  'input #numbers-input' : (e, tmpl) => {
    Session.set('nprIdsToComplete', []);
    Session.set('notFoundNumbers', []);

    var notFoundNumbers = Session.get('notFoundNumbers') || [];
    var entered_numbers = e.target.value.split("\n");
    $.each(entered_numbers, (i, number) =>{
      var npr = NumberPortingRequests.findOne({number: number});
      if(!npr){
        notFoundNumbers.push(number);
        Session.set('notFoundNumbers', notFoundNumbers);
      }else{
        var selectedNprs = Session.get('nprIdsToComplete') || [];
        selectedNprs.push(npr._id._str );
        Session.set('nprIdsToComplete', selectedNprs);
      }
    });
  },

  'click #complete-porting' : (e, tmpl) => {
    Meteor.call('completePorting', Session.get('nprIdsToComplete'));
    Router.go('numberPortingRequestList', null, {query: 'current_tab=completed'} );
  }

});

Template.numberPortingRequestStartedTab.helpers({
  'numberPortingRequests' : function(tmpl) {
    return NumberPortingRequests.find({ portingStartedAt: { $not: null }, portingCompletedAt: null }); 
  }
});

Template.numberPortingRequestStartedTab.rendered = function() {
  Session.set('nprIdsToComplete', []);
  Session.set('notFoundNumbers', []);
};

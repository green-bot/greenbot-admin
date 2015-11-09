Template.numberPortingRequestReadyTab.events({
  'change #select-all' : (e, tmpl) => {
    $('.request-checkbox').prop('checked', e.target.checked).trigger('change');
  },

  'change .request-checkbox' : (e, tmpl) => {
    var selectedNprs = Session.get('nprIdsToPort') || [];
    if(e.target.checked) {
      selectedNprs.push( e.target.value );
    } else {
      selectedNprs = _.without(selectedNprs, e.target.value);
    }
    Session.set("nprIdsToPort", selectedNprs);
  }
});

Template.numberPortingRequestReadyTab.helpers({
  'numberPortingRequests' : function(tmpl) {
    return NumberPortingRequests.find({ ownershipConfirmedAt: { $not: null }, portingStartedAt: null }); 
  },

  'anyRequestsSelected' : function() {
    var selectedNprs = Session.get('nprIdsToPort') || [];
    return selectedNprs.length !== 0;
  }
});

Template.numberPortingRequestReadyTab.rendered = function() {
  Session.set('nprIdsToPort', []);
};

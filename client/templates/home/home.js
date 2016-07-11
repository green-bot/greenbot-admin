import Chart from "chart.js";

Template.home.onCreated( function() {
  this.subscribe('bots')
})

Template.home.helpers({
  bots(){
    return Bots.find();
  }
})

Template.home.onRendered( function() {
  var self = this;

  //var ctx = document.getElementById("chart").getContext("2d");
  //var chart = new Chart(ctx).Line(chartData, { responsive: true });

  self.autorun(function() {
    var sessionsForChart = Template.currentData() || [];
    var datalabels = [];
    var datapoints = [];

    var numDays = 14;

    for(var i=numDays-1; i>=0; i--){
      var date = moment().subtract(i, 'days');
      datalabels.push( date.format("MMM DD") );
      var sessionsCount = _.filter(sessionsForChart, function(s){
        return s.createdAt >= date.startOf('day')._d && s.createdAt < date.endOf('day')._d
      }).length;
      datapoints.push( sessionsCount );
    }

      var chartData = {
        labels: datalabels,
        datasets: [
          {
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: datapoints
          }
        ]
      };
      var ctx = document.getElementById("chart").getContext("2d");
      this.chartObj = new Chart(ctx).Line(chartData, { responsive: true, animation: false });
  });
})

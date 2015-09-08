HTMLWidgets.widget({

  name: 'hello2',

  type: 'output',

  initialize: function(el, width, height) {

    var Chartjs = new Chart(el.getContext("2d"));

    return {
       Chartjs: Chartjs
    }

  },

  renderValue: function(el, x, instance) {

    var data = {
    labels: ["Eating", "Drinking", "Sleeping", "Designing", "Coding", "Cycling", "Running"],
    datasets: [
        {
            label: "My First dataset",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 90, 81, 56, 55, 40]
        },
        {
            label: "My Second dataset",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 96, 27, 100]
        }
    ]
   };

    // Get the context of the canvas element we want to select
    var myRadarChart = instance.Chartjs.Radar(data);


  },

  resize: function(el, width, height, instance) {

  }

});

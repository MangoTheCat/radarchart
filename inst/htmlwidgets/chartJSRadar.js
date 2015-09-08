HTMLWidgets.widget({

  name: 'chartJSRadar',

  type: 'output',

  initialize: function(el, width, height) {

    var Chartjs = new Chart(el.getContext("2d"));

    return {
       Chartjs: Chartjs
    }

  },

  renderValue: function(el, x, instance) {

    var data = x;

    // Get the context of the canvas element we want to select
    var myRadarChart = instance.Chartjs.Radar(data);


  },

  resize: function(el, width, height, instance) {

  }

});

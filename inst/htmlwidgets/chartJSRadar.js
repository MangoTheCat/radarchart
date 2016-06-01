HTMLWidgets.widget({

  name: 'chartJSRadar',

  type: 'output',

  initialize: function(el, width, height) {

    var ctx = el.getContext("2d");

    return {
       Chartjs: ctx
    }

  },

  renderValue: function(el, x, instance) {

    
    // Get the context of the canvas element we want to select
    var myRadarChart = new Chart(instance.ctx, {
        type: 'radar',
        data: x.data,
        options: x.options
    });


  },

  resize: function(el, width, height, instance) {

  }

});

HTMLWidgets.widget({

  name: 'chartJSRadar',

  type: 'output',

  initialize: function(el, width, height) {

    return { };

  },

  renderValue: function(el, x, instance) {

    
    // Get the context of the canvas element we want to select
    var Chartjs = new Chart(
      el.getContext("2d"),
      {
        type: 'radar',
        data: x.data,
        options: x.options
      }
    );
    instance.Chartjs = Chartjs;

  },

  resize: function(el, width, height, instance) {

  }

});

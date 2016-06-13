HTMLWidgets.widget({

  name: 'chartJSRadar',

  type: 'output',

  factory: function(el, width, height) {

    var ctx = el.getContext("2d");

    return {

      renderValue: function(x) {

        // Get the context of the canvas element we want to select
        var myRadarChart = new Chart(ctx, {
            type: 'radar',
            data: x.data,
            options: x.options
        });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
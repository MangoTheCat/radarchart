HTMLWidgets.widget({

  name: 'chartJSRadar',
  type: 'output',

  factory: function(el, width, height) {

    var ctx = el.getContext("2d");
    var instance = new Chart(ctx, {type: 'radar'});

    return {
      renderValue: function(x) {

        if (instance.config.data.datasets.length===0) {
          // Add data for the first time
          instance.config.data = x.data;
          instance.config.options = x.options;
        } else {

          // Remove extraneous datasets
          while (instance.config.data.datasets.length > x.data.datasets.length) {
            instance.config.data.datasets.pop();
          }

          x.data.datasets.forEach(function(dataset, sid) {

            if (instance.config.data.datasets[sid]) {
              // Update the existing datasets
              dataset.data.forEach(function(point, pid) {
                instance.config.data.datasets[sid].data[pid] = point;
              })
              Object.keys(dataset).forEach(function(key) {
                if(key!=='data') { // don't mutate data key
                  instance.config.data.datasets[sid][key] = dataset[key];
                }
              })
            } else {
              // Add new datasets
              instance.config.data.datasets[sid] = dataset;
            }

          })

        }

        // Update the options
        instance.options = Chart.helpers.configMerge(instance.options, x.options);
        instance.update();

      },

      resize: function(width, height) {
        instance.resize();
      },

      instance: instance
    };
  }
});

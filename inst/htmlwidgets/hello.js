HTMLWidgets.widget({

  name: 'hello',

  type: 'output',

  initialize: function(el, width, height) {

    
    //alert('hello');
    



    return {
      // TODO: add instance fields as required
    };

  },

  renderValue: function(el, x, instance) {

    //el.innerText = x.message;
    el.innerText = 'hello...';
    el.setAttribute('style', 'background-color: red');
    
    alert('hello');
    
    
  },

  resize: function(el, width, height, instance) {
     
    alert('hello');
    
  }

});
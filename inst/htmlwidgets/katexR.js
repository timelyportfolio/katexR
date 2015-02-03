HTMLWidgets.widget({

  name: 'katexR',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {

    // empty out our widget el
    el.innerHTML = "";
    katex.render( x.katex, el )
    
  
  },

  resize: function(el, width, height, instance) {

  }

});

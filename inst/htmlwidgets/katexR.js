HTMLWidgets.widget({

  name: 'katexR',

  type: 'output',

  initialize: function(el, width, height) {

    return {
      // TODO: add instance fields as required
    }

  },

  renderValue: function(el, x, instance) {

    // empty out our widget el in case of dynamic or Shiny
    el.innerHTML = "";
    
    // check for blank katex
    //   if blank assume katexR just used for dependency injection
    if( x.katex !== "" ){
      el.style.display = "";
      katex.render( x.katex, el );
      // use expando to attach original KaTeX string
      el.katex = x.katex;
    } else {
      el.style.display = "none";
    }
    
  },

  resize: function(el, width, height, instance) {

  }

});

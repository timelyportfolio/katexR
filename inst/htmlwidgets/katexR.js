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
      try {
        // inline will not wrap the katex with displaystyle
        //  with katexR default will be to wrap with displaystyle{ ... }
        // try to be smart to make sure user has not already
        //  supplied a displaystyle        
        if(x.inline || /(displaystyle)/.exec(x.katex) ){
          katex.render( x.katex, el );
        } else {
          katex.render( '\\displaystyle{' + x.katex + '}', el )
        }
        // use expando to attach original KaTeX string
        el.katex = x.katex;
      } catch(e) {
        el.innerHTML = ["<pre>",x.katex,e.message,"</pre>"].join("\n")
      }
    } else {
      el.style.display = "none";
    }
    
  },

  resize: function(el, width, height, instance) {

  }

});

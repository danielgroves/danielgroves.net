var Loader = function(opts) {
  var spinner = function() {
    var spinnerContainer = document.createElement('span');
    spinnerContainer.classList.add("spinner");
    var spinningImage = document.createElement('img');
    spinningImage.setAttribute('src', opts.loadingImage);
    spinningImage.setAttribute('width', 36);
    spinningImage.setAttribute('height', 36);
    spinnerContainer.appendChild(spinningImage);
    
    return spinnerContainer;
  };
  
  var remove = function(element) {
    try {
      var anchor = element.parentNode;
      anchor.classList.remove('loading-img');
      var spinner = anchor.querySelector('.spinner');
      anchor.removeChild(spinner);
    } catch(ex) {
      if (!(ex instanceof TypeError)) console.error && console.error(ex);
      
      console.info && console.info('Could not remove loading indicator');
      console.debug && console.debug(ex);
    }
  };
  
  var error = function(element) {
    try {
      while(element.tagName != "FIGURE") {
        element = element.parentElement;
      }
      
      element.parentElement.removeChild(element);
    } catch (ex) {
      if (!(ex instanceof TypeError)) console.error && console.error(ex);
       
      console.info && console.info("Could not remove figure element.");
      console.debug && console.debug(ex);
      console.debug && console.debug(msg);
    }
  };
  
  var install = function(loaders) {
    var spriteSpinners = [];
  
    for (var i = 0; i < loaders.length; i++) {
      var element = loaders[i];
      var spinner = this.spinner();
      
      element.appendChild(spinner);
      
      var domSpinner = element.getElementsByClassName('spinner')[0];
      var s = new SpriteSpinner(domSpinner, {
        interval:50
      });

      spriteSpinners.push(s);
      spriteSpinners[spriteSpinners.length - 1].start();
    }
    
    return spriteSpinners
  };
  
  return {
    spinner: spinner,
    remove: remove,
    error: error,
    install: install
  };
};
var Preloader = (function() {
  var options;
  
  var _PreloadIndicator = function(image) {
    var _generateWrapper = function() {
      var loadingCircle = document.createElement('span');
      loadingCircle.classList.add('loading-circle');
      
      var wrapper = document.createElement(options.wrapElement);
      wrapper.classList.add('preloader');
      wrapper.appendChild(loadingCircle);
      
      return wrapper;
    };
    
    var _removePreloader = function(event) {
      var image = this;
      var wrapper = image.parentNode;
      var parent = wrapper.parentNode;
      
      parent.insertBefore(image, wrapper);
      wrapper.remove();
      image.style.opacity = 1;
    };
    
    var _init = function(image) {
      var parent = image.parentNode;
      var wrapper = _generateWrapper();
      
      parent.insertBefore(wrapper, image);
      image.remove();
      wrapper.appendChild(image);
      image.style.opacity = 0;
      
      image.addEventListener("load", _removePreloader);
      image.addEventListener("error", _removePreloader);
    };
    _init(image);
    
    return { };
  };
  
  var ImageLoader = function(opts) {
      var _mergeOpts = function(defaults, opts) {
        for (var attr in defaults) {
          if (!opts.hasOwnProperty(attr)) continue; 
          
          defaults[attr] = opts[attr]; 
        }
        
        return defaults;
      };
    
      var _loadSuccess = function(image) {
        if (options.success) options.success(image);
      };
      
      var _loadError = function(image) {
        if (options.error) options.error(image);
      };
    
      var _loadImage = function(images) {
        if (images.length <= 0) return;
        
        for (var i = 0; i < images.length; i++) {
          var image = images[i];
          
          new _PreloadIndicator(image);
          
          var imageUrl = image.getAttribute('data-src');
          image.setAttribute('src', imageUrl);
          
          image.addEventListener("load", _loadSuccess);
          image.addEventListener("error", _loadError);
        }
      };
      
      var defaults = {
        selector: 'img[data-src]',
        preloaderClass: 'preloader',
        wrapElement: 'div',
        error: undefined,
        success: undefined
      };
      
      if (opts === undefined)
        options = defaults;
      else
        options = _mergeOpts(defaults, opts);
      
      var images = document.querySelectorAll(options.selector);
      _loadImage(images);
      
      return {
      };
  };
  
  return {
      ImageLoader: ImageLoader
  };
})();
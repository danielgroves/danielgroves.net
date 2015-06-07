(function() {
  var SpriteSpinner = function(el, options){
    var img = el.children[0];
    
    this.interval = options.interval || 10;
    this.diameter = options.diameter || img.width;
    this.count = 0;
    this.el = el;
    
    img.setAttribute("style", "position:absolute");
    el.style.width = this.diameter+"px";
    el.style.height = this.diameter+"px";
    el.style.marginLeft = (this.diameter / 2) * -1 + "px";
    el.style.marginTop = (this.diameter / 2) * -1 + "px";
    
    return this;
  };
  
  SpriteSpinner.prototype.start = function() {
    var self = this;
    var count = 0;
    var img = this.el.children[0];
    
    this.el.display = "block";
    self.loop = setInterval(function() {
      if (count == 19)
        count = 0;
    
      img.style.top = (-self.diameter * count) + "px";
      count++;
    }, this.interval);
  
  };
  
  SpriteSpinner.prototype.stop = function() {
    clearInterval(this.loop);
    this.el.style.display = "none";
  };
  window.SpriteSpinner = SpriteSpinner;
})();
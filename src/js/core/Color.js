define([], function() {
  var Color;
  return Color = (function() {
    function Color(r, g, b) {
      this.r = r != null ? r : 0;
      this.g = g != null ? g : 0;
      this.b = b != null ? b : 0;
    }

    Color.prototype.copy = function() {
      return new Color(this.r, this.g, this.b);
    };

    Color.prototype.add = function(c) {
      return new Color(this.r + c.r, this.g + c.g, this.b + c.b);
    };

    Color.prototype.multiply = function(s) {
      return new Color(this.r * s, this.g * s, this.b * s);
    };

    Color.prototype.modulate = function(c) {
      return new Color(this.r * c.r, this.g * c.g, this.b * c.b);
    };

    Color.black = new Color(0, 0, 0);

    Color.white = new Color(255, 255, 255);

    Color.red = new Color(255, 0, 0);

    Color.green = new Color(0, 255, 0);

    Color.blue = new Color(0, 0, 255);

    Color.yellow = new Color(255, 255, 0);

    Color.cyan = new Color(0, 255, 255);

    Color.purple = new Color(255, 0, 255);

    Color.random = function() {
      var b, floor, g, r, random;
      floor = Math.floor;
      random = Math.random;
      r = floor(random() * 255);
      g = floor(random() * 255);
      b = floor(random() * 255);
      return new Color(r, g, b);
    };

    return Color;

  })();
});

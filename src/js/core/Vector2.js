define(function() {
  var Vector2;
  return Vector2 = (function() {
    function Vector2(x, y) {
      this.x = x != null ? x : 0;
      this.y = y != null ? y : 0;
    }

    Vector2.prototype.copy = function() {
      return new Vector2(this.x, this.y);
    };

    Vector2.prototype.length = function() {
      return Math.sqrt(this.x * this.x + this.y * this.y);
    };

    Vector2.prototype.angle = function() {
      return Math.atan2(this.y, this.x);
    };

    Vector2.prototype.add = function(v) {
      return new Vector2(this.x + v.x, this.y + v.y);
    };

    Vector2.prototype.substract = function(v) {
      return new Vector2(this.x - v.x, this.y - v.y);
    };

    Vector2.prototype.dot = function(v) {
      return new Vector2(this.x * v.x, this.y * v.y);
    };

    Vector2.prototype.multiply = function(f) {
      return new Vector2(this.x * f, this.y * f);
    };

    Vector2.prototype.divide = function(f) {
      var invf;
      invf = 1 / f;
      return new Vector2(this.x * invf, this.y * invf);
    };

    Vector2.zero = new Vector2(0, 0);

    Vector2.fromAngle = function(angle, length) {
      return new Vector2(length * Math.cos(angle), length * Math.sin(angle));
    };

    return Vector2;

  })();
});

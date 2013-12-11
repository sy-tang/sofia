define(['../core/Vector', '../core/Color'], function(Vector2, Color) {
  var Particle;
  return Particle = (function() {
    function Particle(options) {
      this.pos = options.pos || Vector2.zero;
      this.velocity = options.velocity || Vector.zero;
      this.acceleration = options.acceleration || Vector2.zero;
      this.life = options.life || 10;
      this.age = options.age || 0;
      this.color = options.color || Color.random();
      this.size = options.size || 1;
    }

    Particle.prototype.render = function(ctx) {
      var alpha;
      alpha = (1 - this.age / this.life).toFixed(2);
      ctx.save();
      ctx.fillStyle = "rgba(" + this.color.r + ", " + this.color.g + ", " + this.color.b + ", " + alpha + ")";
      ctx.translate(this.pos.x, this.pos.y);
      ctx.beginPath();
      ctx.arc(0, 0, this.size, 0, Math.PI * 2, true);
      ctx.closePath();
      ctx.fill();
      return ctx.restore();
    };

    Particle.prototype.move = function(dt) {
      dt = dt || 1;
      this.pos = this.pos.add(this.velocity.multiply(dt));
      return this.velocity = this.velocity.add(this.acceleration.multiply(dt));
    };

    return Particle;

  })();
});

define(function(require) {
  var Color, Emitter, Particle, Vector2;
  Color = require('./Color');
  Vector2 = require('./Vector2');
  Particle = require('./Particle');
  return Emitter = (function() {
    function Emitter(opt) {
      this.pos = opt.pos || new Vector2(0, 0);
      this.originPos = this.pos.copy();
      this.velocity = opt.velocity || new Vector2(0, 0);
      this.spread = opt.spread || Math.PI / 32;
      this.emissionRate = opt.emissionRate || 1;
      this.drawColor = opt.drawColor || Color.red;
      this.minLife = opt.minLife || 5;
      this.maxLife = opt.maxLife || 40;
      this.minSize = opt.minSize || 5;
      this.maxSize = opt.maxSize || 10;
    }

    Emitter.prototype.emitParticle = function() {
      var angle, opt;
      if (this.applyFloat) {
        this.float();
      }
      if (this.applyMouse) {
        this.mouse();
      }
      angle = this.velocity.angle() + this.spread - (Math.random() * this.spread * 2);
      opt = {
        pos: this.pos.copy(),
        velocity: Vector2.fromAngle(angle, this.velocity.length()),
        life: this.minLife + Math.random() * (this.maxLife - this.minLife),
        size: this.minSize + Math.random() * (this.maxSize - this.maxSize)
      };
      return new Particle(opt);
    };

    Emitter.prototype.float = function() {
      var maxHeight;
      this.pos.y += Math.random() * 20 - 10;
      maxHeight = window.innerHeight;
      if (this.pos.y > maxHeight || this.pos.y < 0) {
        return this.pos.y = maxHeight / 2;
      }
    };

    Emitter.prototype.mouse = function() {
      if (window.newMousePostion) {
        return this.pos = window.newMousePostion;
      }
    };

    Emitter.prototype.reset = function() {
      this.pos = this.orignPos.copy();
      return this.applyMouse = this.applyFloat = false;
    };

    return Emitter;

  })();
});

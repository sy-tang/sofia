define(function(require) {
  var Color, Emitter, Particle, ParticleSystem, Vector2;
  Color = require('./Color');
  Vector2 = require('./Vector2');
  Emitter = require('./Emitter');
  Particle = require('./Particle');
  return ParticleSystem = (function() {
    function ParticleSystem(canvas, opt) {
      if (opt == null) {
        opt = {};
      }
      this.canvas = canvas;
      this.ctx = canvas.getContext('2d');
      this.gravity = opt.gravity || new Vector2(0, 10);
      this.gravityOn = opt.gravityOn || false;
      this.stopAging = opt.stopAging || false;
      this.effectors = [];
      this.effectorsOn = opt.effectorsOn || false;
      this.particles = [];
      this.maxParticles = opt.maxParticles || 500;
      this.dt = opt.dt || 0.1;
      this.blurOn = opt.blurOn || false;
      this.emitters = [];
    }

    ParticleSystem.prototype.run = function() {
      this.emit();
      this.simulate();
      return this.render();
    };

    ParticleSystem.prototype.emit = function() {
      var count, emitter, _i, _j, _len, _ref, _ref1;
      if (this.particles.length > this.maxParticles) {
        return;
      }
      _ref = this.emitters;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        emitter = _ref[_i];
        for (count = _j = 0, _ref1 = emitter.emissionRate; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; count = 0 <= _ref1 ? ++_j : --_j) {
          this.particles.push(emitter.emitParticle());
        }
      }
    };

    ParticleSystem.prototype.simulate = function() {
      if (!this.stopAging) {
        this.aging();
      }
      if (this.gravityOn) {
        this.applyGravity();
      }
      if (this.effectorsOn) {
        this.applyfectors();
      }
      return this.kinematics();
    };

    ParticleSystem.prototype.render = function() {
      var p, _i, _len, _ref, _ref1;
      this.ctx.fillStyle = (_ref = this.blurOn) != null ? _ref : {
        'rgba(0, 0, 0, 0.1)': 'black'
      };
      this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
      _ref1 = this.particles;
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        p = _ref1[_i];
        p.render(this.ctx);
      }
    };

    ParticleSystem.prototype.addEffector = function(effector) {
      return this.effectors.push(effector);
    };

    ParticleSystem.prototype.addEmitter = function(emitter) {
      return this.emitters.push(emitter);
    };

    ParticleSystem.prototype.aging = function() {
      var i, p;
      i = 0;
      while (i < this.particles.length) {
        p = this.particles[i];
        p.age += this.dt;
        if (p.age >= p.life) {
          this.kill(i);
        } else {
          i++;
        }
      }
    };

    ParticleSystem.prototype.kill = function(i) {
      var len;
      len = this.particles.length;
      if (len > 1) {
        this.particles[i] = this.particles[len - 1];
        return this.particles.pop();
      }
    };

    ParticleSystem.prototype.applyGravity = function() {
      var p, _i, _len, _ref;
      _ref = this.particles;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        p.acceleration = this.gravity;
      }
    };

    ParticleSystem.prototype.applyEffectors = function() {
      var effector, p, _i, _j, _len, _len1, _ref, _ref1;
      _ref = this.effectors;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        effector = _ref[_i];
        _ref1 = this.particles;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          p = _ref1[_j];
          effector.apply(p);
        }
      }
    };

    ParticleSystem.prototype.kinematics = function() {
      var p, _i, _len, _ref;
      _ref = this.particles;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        p = _ref[_i];
        p.move(this.dt);
      }
    };

    return ParticleSystem;

  })();
});

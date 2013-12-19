// Generated by CoffeeScript 1.6.3
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require) {
  var Color, Emitter, SnowEmitter, SnowParticle, Vector2, _ref;
  Vector2 = require('../../core/Vector2');
  Emitter = require('../../core/Emitter');
  Color = require('../../core/Color');
  SnowParticle = require('./SnowParticle');
  return SnowEmitter = (function(_super) {
    __extends(SnowEmitter, _super);

    function SnowEmitter() {
      _ref = SnowEmitter.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    SnowEmitter.prototype.emitParticle = function() {
      var opt;
      opt = {
        pos: new Vector2(window.innerWidth - Math.random() * window.innerWidth * 1.5, Math.random() * -500),
        velocity: new Vector2(2 - Math.random() * 4, 10),
        life: this.minLife + Math.random() * (this.maxLife - this.minLife),
        size: this.minSize + Math.random() * (this.maxSize - this.minSize),
        color: new Color(255, 255, 255)
      };
      return new SnowParticle(opt);
    };

    return SnowEmitter;

  })(Emitter);
});
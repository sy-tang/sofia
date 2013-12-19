// Generated by CoffeeScript 1.6.3
define(function(require) {
  var ParticleSystem, SnowEffector, SnowEmitter, Vector2, canvas, ps, stats;
  Vector2 = require('core/Vector2');
  SnowEmitter = require('extend/snow/SnowEmitter');
  SnowEffector = require('extend/snow/SnowEffector');
  ParticleSystem = require('core/ParticleSystem');
  stats = require('lib/stats');
  require('lib/requestAnimationFrame');
  canvas = document.getElementById('main');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  window.onresize = function() {
    canvas.width = window.innerWidth;
    return canvas.height = window.innerHeight;
  };
  ps = new ParticleSystem(canvas, {
    dt: 0.08,
    effectorsOn: true,
    gravityOn: true,
    maxParticles: 300
  });
  ps.addEmitter(new SnowEmitter({
    minSize: 1,
    maxSize: 5,
    minLife: 20,
    maxLife: 80,
    emissionRate: 1
  }));
  ps.addEffector(new SnowEffector());
  (function() {
    stats.begin();
    ps.run();
    requestAnimationFrame(arguments.callee);
    return stats.end();
  })();
  return window.ps = ps;
});

define(function(require) {
  var Emitter, ParticleSystem, Vector2, canvas, midX, midY, ps;
  Vector2 = require('core/Vector2');
  Emitter = require('core/Emitter');
  ParticleSystem = require('core/ParticleSystem');
  require('lib/requestAnimationFrame');
  canvas = document.getElementById('main');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  midX = canvas.width / 2;
  midY = canvas.height / 2;
  ps = new ParticleSystem(canvas);
  ps.addEmitter(new Emitter({
    pos: new Vector2(midX, midY),
    velocity: new Vector2(-20, 0),
    spread: Math.PI
  }));
  (function() {
    ps.run();
    return requestAnimationFrame(arguments.callee);
  })();
  return window.ps = ps;
});

define (require) ->
    Vector2 = require('../../core/Vector2')
    Emitter = require('../../core/Emitter')
    Color = require('../../core/Color')
    SmokeParticle = require('./SmokeParticle')

    # extend Emitter to produce smokes
    class SmokeEmitter extends Emitter
        # just need to override emitParticle() to simulate smoke
        emitParticle: ->
            angle = @velocity.angle() + @spread - (Math.random() * @spread * 2)

            opt =
                pos: new Vector2(Math.random() * window.innerWidth, Math.random() * window.innerHeight)
                velocity: Vector2.fromAngle(angle, @velocity.length())
                life: @minLife + Math.random() * (@maxLife - @minLife)
                size: @minSize + Math.random() * (@maxSize - @minSize)

            new SmokeParticle(opt)
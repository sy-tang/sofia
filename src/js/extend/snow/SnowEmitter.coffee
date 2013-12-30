define (require) ->
    Vector2 = require('../../core/Vector2')
    Emitter = require('../../core/Emitter')
    Color = require('../../core/Color')
    SnowParticle = require('./SnowParticle')

    # extend Emitter to produce snow flakes
    class SnowEmitter extends Emitter
        # just need to override emitParticle() to simulate snowing
        emitParticle: ->
            opt =
                pos: new Vector2(window.innerWidth - Math.random() * window.innerWidth * 1.5, Math.random() * -100)
                velocity: new Vector2(2 - Math.random() * 4, 15 + Math.random() * 10)
                life: @minLife + Math.random() * (@maxLife - @minLife)
                size: @minSize + Math.random() * (@maxSize - @minSize)

            new SnowParticle(opt)
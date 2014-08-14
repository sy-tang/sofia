define (require) ->
    Vector2 = require('../../core/Vector2')
    Emitter = require('../../core/Emitter')
    Color = require('../../core/Color')
    SnowParticle = require('./SnowParticle')

    # extend Emitter to produce snow flakes
    class SnowEmitter extends Emitter
        # just need to override emitOne() to simulate snowing
        emitOne: ->
            opt =
                pos: new Vector2(window.innerWidth - Math.random() * window.innerWidth * 1.5, Math.random() * -100)
                velocity: new Vector2(2 - Math.random() * 4, 15 + Math.random() * 10)
                life: @_opt.minLife + Math.random() * (@_opt.maxLife - @_opt.minLife)
                size: @_opt.minSize + Math.random() * (@_opt.maxSize - @_opt.minSize)

            new SnowParticle(opt)
define (require) ->
    Color = require('./Color')
    Vector2 = require('./Vector2')
    Particle = require('./Particle')

    class Emitter
        constructor: (opt) ->
            @pos = opt.pos || new Vector2(0, 0)
            @originPos = @pos.copy()
            @velocity = opt.velocity || new Vector2(0, 0)
            @spread = opt.spread || Math.PI / 32  # possible angles = velocity.angle +/- spread
            @emissionRate = opt.emissionRate || 1

            @drawColor = opt.drawColor || Color.red
            @minLife = opt.minLife || 5
            @maxLife = opt.maxLife || 40
            @minSize = opt.minSize || 5
            @maxSize = opt.maxSize || 10

        emitParticle: ->
            @float() if @applyFloat
            @mouse() if @applyMouse

            angle = @velocity.angle() + @spread - (Math.random() * @spread * 2)

            opt =
                pos: @pos.copy()
                velocity: Vector2.fromAngle(angle, @velocity.length())
                life: @minLife + Math.random() * (@maxLife - @minLife)
                size: @minSize + Math.random() * (@maxSize - @minSize)

            new Particle(opt)

        float: ->
            @pos.y += Math.random() * 20 - 10
            maxHeight = window.innerHeight
            @pos.y = maxHeight / 2 if (@pos.y > maxHeight || @pos.y < 0)

        mouse: ->
            @pos = window.newMousePostion if window.newMousePostion

        reset: ->
            @pos = @orignPos.copy()
            @applyMouse = @applyFloat = false

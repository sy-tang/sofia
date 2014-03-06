define (require) ->

    Util = require('./extend')

    Color = require('./Color')
    Vector2 = require('./Vector2')
    Particle = require('./Particle')

    class Emitter
        constructor: (opt) ->
            @pos = opt.pos || new Vector2(0, 0)
            @velocity = opt.velocity || new Vector2(0, 0)
            @spread = opt.spread || 0   # degree -> [0, 360]
            @emissionRate = opt.emissionRate || 0

            @display = opt.display || false   # show the emitter
            @drawColor = opt.drawColor || Color.red

            @particleProto = ({
                    life: [5, 20]
                    size: [5, 10]
                }).extend(opt.particleProto)


        emitOne: ->

            rand = Util.rand

            opt = Util.clone(@particleProto)

            opt.life = rand(opt.life)
            opt.size = rand(opt.size)

            if !opt.pos
                opt.pos = @pos.clone()

            if opt.posVariance
                variance = opt.posVariance
                opt.pos.add(new Vector2(rand(variance), rand(variance)))

            if opt.velocity
                opt.velocity.rotate(@spread*Math.random())

            new Particle(opt)

        emitParticles: (pool) ->
            count = @emissionRate
            debugger
            while count > 0
                pool.push( @emitOne() )
                count--
            return

        update: (opt) ->
            @.extend(opt)

        move: (dt) ->
            dt = dt || 1
            # update position
            @pos.add @velocity.multiply(dt)

        render: (ctx) ->
            if @display
                ctx.save()
                ctx.fillStyle = "rgba(#{@drawColor.r}, #{@drawColor.g}, #{@drawColor.b}, 1)"
                ctx.translate(@pos.x, @pos.y)
                ctx.beginPath()
                ctx.arc(0, 0, 5, 0, Math.PI * 2, true)
                ctx.closePath()
                ctx.fill()
                ctx.beginPath()
                ctx.fillStyle = '#000'
                ctx.arc(0, 0, 2, 0, Math.PI * 2, true)
                ctx.closePath()
                ctx.fill()
                ctx.restore()




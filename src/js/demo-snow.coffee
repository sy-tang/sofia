define (require) ->
    Vector2 = require('core/Vector2')
    Emitter = require('core/Emitter')
    Color = require('core/Color')
    Particle = require('core/Particle')
    ParticleSystem = require('core/ParticleSystem')

    require('lib/requestAnimationFrame')

    # extend Particle to draw snow flakes
    class SnowParticle extends Particle
        render: (ctx) ->
            scale = alpha = (1 - @age / @life).toFixed(2)
            ctx.save()
            ctx.fillStyle = "rgba(#{@color.r}, #{@color.g}, #{@color.b}, #{alpha})"
            ctx.translate(@pos.x, @pos.y)
            ctx.beginPath()
            ctx.arc(0, 0, @size * scale, 0, Math.PI * 2, true)
            ctx.closePath()
            ctx.fill()
            ctx.restore()

    # extend Emitter to produce snow flakes
    class SnowEmitter extends Emitter
        # just need to override emitParticle() to simulate snowing
        emitParticle: ->
            opt =
                pos: new Vector2(window.innerWidth - Math.random() * window.innerWidth * 1.5, Math.random() * -10)
                velocity: new Vector2(@velocity.x + Math.random() * 10, @velocity.y)
                life: @minLife + Math.random() * (@maxLife - @minLife)
                size: @minSize + Math.random() * (@maxSize - @minSize)
                color: new Color(255, 255, 255)

            new SnowParticle(opt)


    canvas = document.getElementById('main')
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight

    window.onresize = () ->
        canvas.width = window.innerWidth
        canvas.height = window.innerHeight

    ps = new ParticleSystem(canvas, {
            dt: 0.08
            maxParticles: 2000
        })

    # add SnowEmitter to make snow flakes in the system
    ps.addEmitter(new SnowEmitter({
            velocity: new Vector2(20, 40)
            minSize: 1
            maxSize: 5
            minLife: 20
            maxLife: 40
            emissionRate: 2
        })
    )

    do () ->
        ps.run()
        requestAnimationFrame(arguments.callee)

    window.ps = ps

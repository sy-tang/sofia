define (require) ->
    Particle = require('../../core/Particle')

    # extend Particle to draw snow flakes
    class SnowParticle extends Particle
        render: (ctx) ->
            # scale = alpha = (1 - @age / @life).toFixed(2)

            ctx.save()
            ctx.translate(@pos.x, @pos.y)
            gradient = ctx.createRadialGradient(0, 0, 0, 0, 0, @size)
            gradient.addColorStop(0, "rgba(255, 255, 255, 0.9)")
            gradient.addColorStop(0.5, "rgba(255, 255, 255, 0.5)")
            gradient.addColorStop(1, "rgba(255, 255, 255, 0)")
            ctx.fillStyle = gradient
            # ctx.fillStyle = "rgba(#{@color.r}, #{@color.g}, #{@color.b}, #{alpha})"
            ctx.beginPath()
            ctx.arc(0, 0, @size, 0, Math.PI * 2, true)
            ctx.closePath()
            ctx.fill()
            ctx.restore()
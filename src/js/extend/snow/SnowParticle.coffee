define (require) ->
    Particle = require('../../core/Particle')

    # extend Particle to draw snow flakes
    class SnowParticle extends Particle
        render: (ctx) ->
            scale = alpha = (1 - @age / @life).toFixed(2)
            ctx.save()
            ctx.fillStyle = "rgba(#{@color.r}, #{@color.g}, #{@color.b}, #{alpha})"
            ctx.translate(@pos.x, @pos.y)
            ctx.beginPath()
            ctx.arc(0, 0, @size, 0, Math.PI * 2, true)
            ctx.closePath()
            ctx.fill()
            ctx.restore()
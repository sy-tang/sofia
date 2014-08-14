define (require) ->

    Color = require('./Color')
    Vector2 = require('./Vector2')

    class Particle
        constructor: (options) ->
            @pos = options.pos || Vector2.zero.clone()
            @velocity = options.velocity || Vector2.zero.clone()
            @acceleration = options.acceleration || Vector2.zero.clone()
            @life = options.life || 10
            @age = options.age || 0
            @color = options.color || Color.random()
            @size = options.size || 1


        render: (ctx) ->
            alpha = (1 - @age / @life).toFixed(2)
            ctx.save()
            ctx.fillStyle = "rgba(#{@color.r}, #{@color.g}, #{@color.b}, #{alpha})"
            ctx.translate(@pos.x, @pos.y)
            ctx.beginPath()
            ctx.arc(0, 0, @size, 0, Math.PI * 2, true)
            ctx.closePath()
            ctx.fill()
            ctx.restore()

        move: (dt) ->
            dt = dt || 1
            # update position
            @pos.add @velocity.multiply(dt)

            # update velocity
            @velocity.add @acceleration.multiply(dt)

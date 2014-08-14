define (require) ->
    class ChanmberBox
        constructor: (@x1, @y1, @x2, @y2) ->

        apply: (particle) ->
            if(particle.pos.x - particle.size < @x1 || particle.pos.x + particle.size > @x2)
                particle.velocity.x = -particle.velocity.x

            if(particle.pos.y - particle.size < @y1 || particle.pos.y + particle.size > @y2)
                particle.velocity.y = -particle.velocity.y

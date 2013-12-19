define (require) ->
    class SnowEffector
        apply: (particle) ->
            # change particle's velocity
            particle.velocity.x += (1 - Math.random() * 2) / 10

            if(particle.pos.x > window.innerWidth || particle.pos.y > window.innerHeight)
                particle.age = particle.life

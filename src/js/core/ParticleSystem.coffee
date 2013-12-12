define (require) ->
    Color = require('./Color')
    Vector2 = require('./Vector2')
    Emitter = require('./Emitter')
    Particle = require('./Particle')

    class ParticleSystem
        constructor: (canvas, opt = {}) ->
            @canvas = canvas
            @ctx = canvas.getContext('2d')

            @gravity = opt.gravity or new Vector2(0, 10)
            @gravityOn = opt.gravityOn || false
            @stopAging = opt.stopAging || false
            @effectors = []
            @effectorsOn = opt.effectorsOn || false
            @particles = []
            @maxParticles = opt.maxParticles || 500
            @dt = opt.dt || 0.1
            @blurOn = opt.blurOn || false

            @emitters = []

        run: ->
            @emit()
            @simulate()
            @render()

        emit: ->
            return if @particles.length > @maxParticles
            for emitter in @emitters
                for count in [0..emitter.emissionRate]
                    @particles.push emitter.emitParticle()
            return

        simulate: ->
            @aging() if not @stopAging
            @applyGravity() if @gravityOn
            @applyfectors() if @effectorsOn
            @kinematics()

        render: () ->
            @ctx.fillStyle = @blurOn ? 'rgba(0, 0, 0, 0.1)' : 'black'
            @ctx.fillRect(0, 0, @canvas.width, @canvas.height)
            p.render(@ctx) for p in @particles
            return

        addEffector: (effector) ->
            @effectors.push(effector)

        addEmitter: (emitter) ->
            @emitters.push(emitter)

        aging: () ->
            i = 0
            while i < @particles.length
                p = @particles[i]
                p.age += @dt
                if p.age >= p.life
                    @kill(i)
                else i++
            return

        kill: (i) ->
            len = @particles.length
            if len > 1
                @particles[i] = @particles[len - 1]
                @particles.pop()

        applyGravity: () ->
            for p in @particles
                p.acceleration = @gravity
            return

        applyEffectors: () ->
            for effector in @effectors
                for p in @particles
                    effector.apply(p)
            return

        kinematics: () ->
            for p in @particles
                p.move(@dt)
            return

define (require) ->
    Vector2 = require('core/Vector2')
    SnowEmitter = require('extend/snow/SnowEmitter')
    SnowEffector = require('extend/snow/SnowEffector')
    ParticleSystem = require('core/ParticleSystem')

    stats = require('lib/stats')

    require('lib/requestAnimationFrame')
    require('/bower_components/dat.gui/dat.gui.min.js')

    canvas = document.getElementById('main')
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight

    window.onresize = () ->
        canvas.width = window.innerWidth
        canvas.height = window.innerHeight

    ps = new ParticleSystem(canvas, {
            dt: 0.08
            effectorsOn: true
            maxParticles: 500
            stopAging: true
        })

    # add SnowEmitter to make snow flakes in the system
    ps.addEmitter(new SnowEmitter({
            minSize: 1
            maxSize: 8
            minLife: 20
            maxLife: 80
            emissionRate: 1
        })
    )

    ps.addEffector(new SnowEffector())

    do () ->
        stats.begin()
        ps.run()
        requestAnimationFrame(arguments.callee)
        stats.end()

    window.ps = ps

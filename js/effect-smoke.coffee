define (require) ->
    Vector2 = require('core/Vector2')
    SmokeEmitter = require('extend/smoke/SmokeEmitter')
    ChamberBox = require('extend/ChamberBox')
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

    midX = canvas.width / 2
    midY = canvas.height / 2

    window.showCenter = false

    ps = new ParticleSystem(canvas, {
            maxParticles: 200
            effectorsOn: true
            stopAging: true
        })

    ps.addEffector(new ChamberBox(0, 0, canvas.width, canvas.height))

    ps.addEmitter(new SmokeEmitter({
            pos: new Vector2(midX, midY)
            velocity: new Vector2(-20, 0)
            spread: Math.PI
            emissionRate: 60
        })
    )

    # add control panel
    gui = new dat.GUI()
    gui.add(window, 'showCenter')


    do () ->
        stats.begin()
        ps.run()
        requestAnimationFrame(arguments.callee)
        stats.end()

    window.ps = ps

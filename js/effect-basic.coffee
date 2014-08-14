define (require) ->
    Vector2 = require('core/Vector2')
    Emitter = require('core/Emitter')
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

    canvas.onmousemove = (e) ->
        if (e.layerX || e.layerX == 0)  # Firefox
            e.target.style.position = 'relative'
            window.newMousePosition = new Vector2(e.layerX, e.layerY)
        else
            window.newMousePosition = new Vector2(e.offsetX, e.offsetY)

    midX = canvas.width / 2
    midY = canvas.height / 2

    ps = new ParticleSystem(canvas)

    emitter = new Emitter({
            pos: new Vector2(midX, midY)
            velocity: new Vector2(-20, 0)
            spread: Math.PI
        })
    ps.addEmitter(emitter)

    ps.addEffector(new ChamberBox(0, 0, canvas.width, canvas.height))

    # add control panel
    gui = new dat.GUI()
    emitterCtl = gui.addFolder('Emitter')
    psCtl = gui.addFolder('Particle system')

    emitterCtl.add(emitter, 'emissionRate', 1, 30)
    emitterCtl.add(emitter, 'applyMouse').listen()
    emitterCtl.add(emitter, 'reset')

    psCtl.add(ps, 'maxParticles', 0, 1000)
    psCtl.add(ps, 'gravityOn')
    psCtl.add(ps, 'effectorsOn')
    psCtl.add(ps, 'blurOn')

    do () ->
        stats.begin()
        ps.run()
        requestAnimationFrame(arguments.callee)
        stats.end()

    window.ps = ps

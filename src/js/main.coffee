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
            particleProto:
                velocity: new Vector2(0, 10)
                posVariance: 0
            emissionRate: 0
            spread: 360
            display: true
        })
    ps.addEmitter(emitter)

    ps.addEffector(new ChamberBox(0, 0, canvas.width, canvas.height))

    # add control panel
    gui = new dat.GUI()

    psCtl = gui.addFolder('Particle system')
    psCtl.add(ps, 'maxParticles', 0, 1000)
    psCtl.add(ps, 'gravityOn')
    psCtl.add(ps, 'effectorsOn')
    psCtl.add(ps, 'blurOn')
    psCtl.open()

    emitterCtl = gui.addFolder('Emitter')
    emitterCtl.add(emitter.pos, 'x', 0, canvas.width).step(5).name('position-x')
    emitterCtl.add(emitter.pos, 'y', 0, canvas.height).step(5).name('position-y')
    emitterCtl.add(emitter.velocity, 'x').step(5).name('velocity-x')
    emitterCtl.add(emitter.velocity, 'y').step(5).name('velocity-y')
    emitterCtl.add(emitter, 'spread', 0, 360)
    emitterCtl.add(emitter, 'emissionRate', 0, 30).step(1)
    emitterCtl.add(emitter, 'display')
    emitterCtl.open()

    particleCtl = gui.addFolder('Particle Prototype')
    particleCtl.add(emitter.particleProto, 'posVariance').name('position variance')
    particleCtl.add(emitter.particleProto.velocity, 'x').name('velocity-x')
    particleCtl.add(emitter.particleProto.velocity, 'y').name('velocity-y')
    particleCtl.open()



    do () ->
        stats.begin()
        ps.run()
        requestAnimationFrame(arguments.callee)
        stats.end()

    window.ps = ps

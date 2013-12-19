define (require) ->
    Particle = require('../../core/Particle')

    # Create an image object (only need one instance)
    imageObj = new Image()

    imageLoaded = false

    imageObj.onload = () ->
        imageLoaded = true

    # Once the callback is arranged then set the source of the image
    imageObj.src = "../../../img/smoke.png"

    # extend Particle to draw smoke
    class SmokeParticle extends Particle
        render: (ctx) ->
            ctx.save()
            if(imageLoaded)
                ctx.drawImage(imageObj, @pos.x-128, @pos.y-128)
                return
            ctx.fillStyle = "rgba(255, 0, 0, 1)"
            ctx.translate(@pos.x, @pos.y)
            ctx.beginPath()
            ctx.arc(0, 0, @size, 0, Math.PI * 2, true)
            ctx.closePath()
            ctx.fill()
            ctx.restore()
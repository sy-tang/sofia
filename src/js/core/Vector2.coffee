define () ->
    class Vector2
        constructor: (@x = 0, @y = 0) ->

        clone: ->
            new Vector2(@x, @y)

        copy: ->
            new Vector2(@x, @y)

        length: ->
            Math.sqrt(@x * @x + @y * @y)

        angle: ->
            Math.atan2(@y, @x)

        add: (v) ->
            @x += v.x
            @y += v.y
            return @

        substract: (v) ->
            @x -= v.x
            @y -= v.y
            return @

        dot: (v) ->
            @x = @x * v.x
            @y = @y * v.y
            return @

        multiply: (f) ->
            return new Vector2(@x*f, @y*f)

        divide: (f) ->
            invf = 1 / f;
            @x = @x * invf
            @y = @y * invf
            return @

        rotate: (degree) ->
            rad = degree * Math.PI / 180
            cos = Math.cos(rad)
            sin = Math.sin(rad)
            _x = @x
            _y = @y
            @x = _x * cos - _y * sin
            @y = _x * sin + _y * cos
            return @

        @zero: new Vector2(0, 0)

        # Get a new Vector2 from angle and length
        @fromAngle: (angle, length) ->
            new Vector2(length * Math.cos(angle), length * Math.sin(angle))

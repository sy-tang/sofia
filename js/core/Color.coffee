# Color: r,g,b -> [0, 255]
define () ->
    class Color
        constructor: (@r = 0, @g = 0, @b = 0) ->

        clone: ->
            new Color(@r, @g, @b)

        copy: ->
            new Color(@r, @g, @b)

        add: (c) ->
            new Color(@r + c.r, @g + c.g, @b + c.b)

        multiply: (s) ->
            new Color(@r * s, @g * s, @b * s)

        modulate: (c) ->
            new Color(@r * c.r, @g * c.g, @b * c.b)

        @black: new Color(0, 0, 0)

        @white: new Color(255, 255, 255)

        @red: new Color(255, 0, 0)

        @green: new Color(0, 255, 0)

        @blue: new Color(0, 0, 255)

        @yellow: new Color(255, 255, 0)

        @cyan: new Color(0, 255, 255)

        @purple: new Color(255, 0, 255)

        @random: ->
            floor = Math.floor
            random = Math.random

            r = floor(random() * 255);
            g = floor(random() * 255);
            b = floor(random() * 255);

            new Color(r, g, b)

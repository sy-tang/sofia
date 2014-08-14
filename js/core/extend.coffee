define () ->
    Object::extend = (objects...) ->
        for object in objects
            for key, value of object
                @[key] = value
        return @

    Util =
        rand : (range) ->
            if range instanceof Array
                return range[0] + Math.random() * (range[1] - range[0])
            else
                return Math.random() * 2 * range - range

        clone : (obj) ->
            if not obj? or typeof obj isnt 'object'
                return obj

            if obj instanceof Date
                return new Date(obj.getTime())

            if obj instanceof RegExp
                flags = ''
                flags += 'g' if obj.global?
                flags += 'i' if obj.ignoreCase?
                flags += 'm' if obj.multiline?
                flags += 'y' if obj.sticky?
                return new RegExp(obj.source, flags)

            newInstance = new obj.constructor()

            for key of obj
                newInstance[key] = arguments.callee obj[key]

            return newInstance

        dragging: (options) ->
            ###
                options:
                    selector: string
                    data: any
                    mouse_down: (e) ->
                    mouse_move: (e) ->
                    mouse_up: (e) ->
                    window: object
                        Useful when using in an iframe.
            ###

            if options.window
                win = options.window
            else
                win = window

            $doc = $(win.document)

            mouse_down = (e) ->
                e.data = options.data
                options.mouse_down?(e)

                $doc.mousemove(mouse_move)
                $doc.one('mouseup', mouse_up)

            mouse_move = (e) ->
                e.data = options.data
                options.mouse_move?(e)

            mouse_up = (e)->
                e.data = options.data
                options.mouse_up?(e)

                # Release event resource.
                $doc.off('mousemove', mouse_move)

            $doc.on('mousedown', options.selector, mouse_down)

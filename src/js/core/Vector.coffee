define [], () ->
	class Vector2
		constructor: (@x = 0, @y = 0) ->

		copy: ->
			new Vector2(@x, @y)

		length: ->
			Math.sqrt(@x * @x + @y * @y)

		angle: ->
			Math.atan2(@y, @x)

		add: (v) ->
			new Vector2(@x + v.x, @y + v.y)

		substract: (v) ->
			new Vector2(@x - v.x, @y - v.y)

		dot: (v) ->
			new Vector2(@x * v.x, @y * v.y)

		multiply: (f) ->
			new Vector2(@x * f, @y * f)

		divide: (f) ->
			invf = 1 / f;
			new Vector2(@x * invf, @y * invf)

		@zero: new Vector2(0, 0)

		# Get a new Vector2 from angle and length
		@fromAngle: (angle, length) ->
			new Vector2(length * Math.cos(angle), length * Math.sin(angle))






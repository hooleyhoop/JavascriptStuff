ABoo.BusyFadeHelper = SC.Object.extend
	_fadeTimeStart: undefined
	_fadeTimeEnd: undefined
	_fadeStartVal: undefined
	_fadeEndVal: undefined
	_fadeComplete: undefined
	_target: undefined
	_property: undefined
	_ended: undefined

	animate: ( target, property, endVal, duration, completeCallback ) ->
		@_target = target
		@_property = property
		@_fadeStartVal = target.get(property)
		@_fadeEndVal = endVal
		@_fadeTimeStart = new Date().getTime()
		@_fadeTimeEnd = @_fadeTimeStart+duration
		@_fadeComplete = completeCallback
		@_ended = false

	update: (time) ->

		if(@_ended)
			@_didEnd()
			return

		updatedVal
		if time > @_fadeTimeEnd
			updatedVal = @_fadeEndVal
			@_ended = true		#defer completion till next cycle (so we are certain to draw the end state)
		else
			updatedVal = ABoo.HooMath.lerp( @_fadeTimeStart, @_fadeStartVal, @_fadeTimeEnd, @_fadeEndVal, time )

		#console.log("fade "+updatedVal)
		if(isNaN(updatedVal))
			debugger
		@_target.set( @_property, updatedVal )
	

	_didEnd: () ->
		#console.log("doing callback")
		@_fadeComplete()
		@_fadeComplete = null

	timeUpdate: ( time ) ->
		@update(time)

ABoo.HooPropertyAnimator = SC.Object.extend
	_fadeTimeStart: undefined
	_fadeTimeEnd: undefined
	_fadeStartVal: undefined
	_fadeEndVal: undefined
	_fadeComplete: undefined
	_target: undefined
	_property: undefined
	_ended: undefined

	init: () ->
		@_super
		
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

		skippedLerp = false
		
		if time <= @_fadeTimeStart
			updatedVal = @_fadeStartVal # i really dont know how this is happening
			
		else if time >= @_fadeTimeEnd
			updatedVal = @_fadeEndVal
			@_ended = true		#defer completion till next cycle (so we are certain to draw the end state)
			skippedLerp = true
		else
			updatedVal = ABoo.HooMath.lerp( @_fadeTimeStart, @_fadeStartVal, @_fadeTimeEnd, @_fadeEndVal, time )

			if(isNaN(updatedVal))
				debugger
		
		#¢console.log("fade "+@_property+" "+updatedVal)

		@_target.set( @_property, updatedVal )
	

	_didEnd: () ->
		#console.log("doing callback")
		@_fadeComplete()
		@_fadeComplete = null

	timeUpdate: ( time ) ->
		HOO_nameSpace.assert( time, "time? time? time?" );
		@update(time)

	forceSetValue: (val) ->
		@_target.set( @_property, val )

		
ABoo.PropertyAnimMixin =
	_propertyAnimations: undefined

	# should be ok to keep piling these ontop of each other
	animateProperty: ( propertyName, to, duration ) ->
		if(!@_propertyAnimations)
			@_propertyAnimations = new Object()

		animator = @_propertyAnimations[propertyName]
		if(!animator)
			console.log("animating "+propertyName)			
			animator = ABoo.HooPropertyAnimator.create()
			ABoo.ShiteDisplayLink.sharedDisplayLink.registerListener( animator )
			@_propertyAnimations[propertyName] = animator

		animComplete = () =>
			ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener( animator )
			@_propertyAnimations[propertyName] = null

		animator.animate( this, propertyName, to, duration, animComplete )

	# use this to kill existing animations and cold set the value
	coldSetProperty: ( propertyName, to ) ->
		if @_propertyAnimations?
			animator = @_propertyAnimations[propertyName]
			if animator?
				ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener( animator )
				animator.forceSetValue(to)
				animator._fadeComplete = null
				@_propertyAnimations[propertyName] = null
		else
			@set(propertyName,to)
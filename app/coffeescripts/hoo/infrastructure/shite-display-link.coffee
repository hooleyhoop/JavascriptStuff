ABoo.ShiteDisplayLink = SC.Object.extend
	_listeners: undefined
	_canvasElements: undefined
	_running: false
	_timer: undefined
	_time: 0

	init: () ->
		@_super()
		@_listeners = new Array()
		@_canvasElements = new Array()
		@_time = (new Date()).getTime()

	registerListener: ( listener ) ->
		@_listeners.push( listener )
		if(@_running==false && @_listeners.length>0 )
			@start()

	unregisterListener: ( listener ) ->
		i = @_listeners.indexOf(listener)
		if(i>-1)
			@_listeners.splice(i,1)
		if( @_running && @_canvasElements.length==0 && @_listeners.length==0 )
			@stop()

	registerCanvas: ( canvas ) ->
		@_canvasElements.push( canvas )
		if( @_running==false && @_canvasElements.length>0 )
			@start()

	unregisterCanvas: ( canvas ) ->
		#console.warn("unregisterCanvas CANVAS!")
		wasRunning = false
		if( @_running )
			@stop()
			wasRunning = true

		i = @_canvasElements.indexOf(canvas)
		if(i>-1)
			@_canvasElements.splice(i,1)
			#console.warn("removed canvas from array CANVAS!")

		if( wasRunning && (@_canvasElements.length>0 || @_listeners.length>0) )
			#console.warn("restarting DSIPLAY LINK because: was running? "+wasRunning +", "+@_canvasElements.length+" canvases, "+@_listeners.length+" listeners" )
			@start()
		else
			console.warn("Not restarting DSIPLAY LINK because: "+wasRunning+" "+@_canvasElements.length+" "+@_listeners.length )

	start: () ->
		#console.warn("STARTING DISPLAY LINK!")
		@_timer = setInterval( () =>
			# woo! run the callback inside an sc runloop
			try
				SC.run( this, @_callback ) #@_callback.call(this)
			catch e
				alert(e)
				debugger
		, 1000/50.0)
		# TODO: we should monitor the actual rate that we achieve and adjust accordingly
		@_running = true

	stop: () ->
		#console.warn("STOPPING DISPLAY LINK!")
		clearInterval( @_timer )
		@_timer = null
		@_running = false

	_callback: () ->
		HOO_nameSpace.assert( @_canvasElements.length>0 or @_listeners.length>0, "why am i drawing with no listeners or canvases?")
	
		#console.log("ENTER TIMER::"+@_timer)
		@_time = (new Date()).getTime()
		t = @_time
		listenersCopy = @_listeners.slice(0)
		$.each( listenersCopy, (indexInArray, valueOfElement) ->
			valueOfElement.timeUpdate( t )
		)
		#this could mutate the array
		canvasElementsCopy = @_canvasElements.slice(0)
		$.each( canvasElementsCopy, (indexInArray, valueOfElement) ->
			valueOfElement.displayUpdate( t )
		)
		#console.log("EXIT TIMER::"+@_timer)


ABoo.ShiteDisplayLinkClassMethods =
	sharedDisplayLink: undefined

SC.mixin( ABoo.ShiteDisplayLink, ABoo.ShiteDisplayLinkClassMethods )

# create the singleton
ABoo.ShiteDisplayLink.sharedDisplayLink = ABoo.ShiteDisplayLink.create()


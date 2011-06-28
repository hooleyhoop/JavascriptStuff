# When we need some different kinds of graphics start chopping up this heirarchy

# All elements must be constructable at run time or compile time
# !! anytime you use a property that you assume will be there add it to the list..

ABoo.HooPlayPauseButtonGraphic = ABoo.HooAbstractButtonGraphic.extend( ABoo.HooCanvasViewMixin,
	_playButtonSprite: undefined
	_pauseButtonSprite: undefined
	_currentSpriteState: undefined
	_currentSprite: undefined
	_percentOfCanvas:undefined

	_threeStateButtonStateMachine_config:
		"disabled":
			"movieclip": "_playButtonSprite"
			"properties": { _isDisabled: true, _isDown: false }
		"play":
			"movieclip": "_playButtonSprite"
			"properties": { _isDisabled: false, _isDown: false }
		"play_down":
			"movieclip": "_playButtonSprite"
			"properties": { _isDisabled: false, _isDown: true }
		"pause":
			"movieclip": "_pauseButtonSprite"
			"properties": { _isDown: false }
		"pause_down":
			"movieclip": "_pauseButtonSprite"
			"properties": { _isDown: true }

	
	init: () -> # _percentOfCanvas #
		@_super();
		@_playButtonSprite = ABoo.PlayButtonSprite.create()
		@_pauseButtonSprite = ABoo.PauseButtonSprite.create()

	description: () ->
		return "HooPlayPauseButtonGraphic"

	getClickableItem: () ->
		HOO_nameSpace.assert( @_parentCanvas, "this button must be added to a canvas to work" )
		return @_parentCanvas._$canvas

	# canvas -> HooCanvasViewMixin
	drawContents: ( ctx, width, height ) ->
		if(!@_currentSprite)
			return
		insetWidth = width*@_percentOfCanvas
		insetHeight = height*@_percentOfCanvas
		x = (width-insetWidth)/2.0
		y = (height-insetHeight)/2.0
		@_currentSprite.spriteDraw( ctx, x, y, insetWidth, insetHeight )

	showDisabledButton: () ->
		@transitionToSpriteState("disabled")
	showMouseUp1State: () ->
		@transitionToSpriteState("play")
	showMouseDown1State: () ->
		@transitionToSpriteState("play_down")
	showMouseUp2State: () ->
		@transitionToSpriteState("pause")
	showMouseDown2State: () ->
		@transitionToSpriteState("pause_down")

	transitionToSpriteState: ( state ) ->
		if(state!=@_currentSpriteState)
			stateDict = @_threeStateButtonStateMachine_config[state]
			shouldBeVisibleSpriteName = stateDict["movieclip"]
			@_currentSprite = @get(shouldBeVisibleSpriteName)

			# make the current Sprite have the correct properties
			shouldBePropertyValuesDict = stateDict["properties"]
			@_currentSprite.setPropertiesOfSprite( shouldBePropertyValuesDict )

			@_currentSpriteState = state
			if(@_parentCanvas)
				@_parentCanvas.setNeedsDisplay()

	getOuterWidth: () ->
		debugger
		return undefined

	setOuterWidth: ( arg ) ->
		debugger
		return undefined

	getTextContent: () ->
		debugger
		return undefined
		
	getHref: () ->
		debugger
		return undefined
		
	setBackgroundAndTextState: ( state ) ->
		debugger
		return undefined
		
	setContentText:  ( arg ) ->
		debugger
		return undefined
		
	positionBackground:( state ) ->
		debugger
		return undefined
)

ABoo.HooPlayPauseButton = ABoo.HooFormButtonToggle.extend

	# _started: false,
	_hooCanvas: undefined

	_createGraphic: () ->
		@_buttonGraphic = ABoo.HooPlayPauseButtonGraphic.create( { _rootItemId:@id, _percentOfCanvas:@json.percentOfCanvas })

	setupDidComplete: () ->

		# this is a bit fucked because canvas becomes graphics clickable item
		HOO_nameSpace.assert( @_hooCanvas, "this button must be added to a canvas to work" )
		@_hooCanvas.addSubview( @_buttonGraphic )
		@_super();

		#var self = @;
		#setTimeout( function(){
			# self.resizeAll();
		#}, 100 );


		# @_started = true;
		# ShiteDisplayLink.sharedDisplayLink.registerListener(@);
	

	# TODO! ok, i dont know which way round sizing should work - resize the canvas or the player? Or both?
	#resizeAll: () ->
	#	var newWidth = @div$.width();
	#	var newHeight = @div$.outerHeight();
	#	@_buttonGraphic.setSize( newWidth, newHeight );
	#}



ABoo.SmallPlayerPlayButton = ABoo.HooWidget.extend
	_radialProgress: undefined
	_playPauseButton: undefined

	init: ()  ->
		@_super()

	setupDidComplete: () ->
		0




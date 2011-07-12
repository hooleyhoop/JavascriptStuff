
### abstract superclass for flash and html5
###
ABoo.NewHeadlessPlayerSingleton = SC.Object.extend

	_audioPlayingDomNode: undefined
	_mp3url: undefined

	# autoload doesn't do much, if you set the src, in html5, it will load
	setSrc: ( mp3Url2, autoload, autoplay ) ->
		if !mp3Url2?
			debugger

		if @_mp3url != mp3Url2
			@_mp3url = mp3Url2
			console.log( "SRC: " + mp3Url2 )

			#@_audioPlayingDomNode.attrSetter( 'preload', "auto" )
			if autoplay==true
				@_audioPlayingDomNode.attrSetter( 'autoplay', 'autoplay' )
				autoload = true

			@_audioPlayingDomNode.attrSetter( 'src', mp3Url2 )

			if autoload==true
				@_audioPlayingDomNode.cmd( 'load' ) 					# force the audio to reset & start loading the new url
		0

	# hm
	playerBecameCurrent: ( playerInstance, $pageItem ) ->
		# NB, it only physically swaps in when fails to load due to flash blocker
		@_audioPlayingDomNode.swapInForItem( playerInstance, $pageItem )
		0

	# Abstract - make sure you overide this..
	_getTimeRangeEnd: ( timeRanges, timeRangeIndex ) ->
		debugger
		0

	# hm
	buffered: () ->
		endTime = 0
		timeRanges = @_audioPlayingDomNode.getNodeProperty('buffered')
		if !timeRanges?
			console.log("Buffered attribute NOT found")
			return 0
		if timeRanges.length > 0
			try
				# Discount the possibility of multiple buffers for now (theoretically possible with range requests if the user skips forward, but Safari doesn't seem to support it)
				# and just return the proportion of buffered time
				timeRangeIndex = timeRanges.length-1
				endTime = @_getTimeRangeEnd( timeRanges, timeRangeIndex ) #implemented differently for flash and html5
			catch error
				alert error
				return 0
		return endTime

	#
	duration: () ->
		dur = @_audioPlayingDomNode.getNodeProperty('duration')
		if isNaN(dur) then dur = 0
		#console.log("DUR: "+dur)
		return dur

	loadedDegrees: () ->
		buffered = @buffered()
		duration = @duration()
		loadedDegrees = if duration is 0 then 0 else (buffered / duration * 360)
		#console.log("<<<<< loadedDegrees: "+buffered+" "+duration+" >>>>>> "+loadedDegrees )
		return loadedDegrees

	playedDegrees: () ->
		ct = @_audioPlayingDomNode.attrGetter('currentTime')
		duration =  @duration()
		playedDegrees = if duration is 0 then 0 else (ct / duration * 360)
		console.log("<<<<< playedDegrees: "+ct+" "+duration+" >>>>>> "+playedDegrees )
		return playedDegrees
		
	# TODO: when you play we have to manually update playcount (first time thru only) - sort out what happens when autoplay
	play: () ->
		@_audioPlayingDomNode.cmd( 'play' )

	pause: () ->
		@_audioPlayingDomNode.cmd( 'pause' )

	setCurrentTime: ( secs ) ->
		@_audioPlayingDomNode.attrSetter( 'currentTime', secs )

SC.mixin( ABoo.NewHeadlessPlayerSingleton, ABoo.SingletonClassMethods )


### one of these for each instance of a player
###
ABoo.NewHeadlessPlayer = SC.Object.extend
	_mp3URL: undefined
	_controller: undefined
	_watchableEvents: 'error emptied loadstart progress loadeddata loadedmetadata durationchange timeupdate canplay canplaythrough waiting play ended abort dataunavailable empty pause ratechange seeked seeking volumechange stalled'
	_stateMachine: undefined
	_state: false
	_headLessSingleton: undefined
		
	_attachToPage: ( $pageItem ) ->
		@_createSingletonPlayer()
		@_stateMachine = ABoo.AudioPlayerStateMachine.create( {_controller: @_controller } )
		@_headLessSingleton.playerBecameCurrent( this, $pageItem )
		
	# this doesn't mean that the swf is ready
	didSwapInFlash: ( swf ) ->
		@_state = true
		#console.log("SWApped in")

	didSwapOutFlash: ( swf ) ->
		#console.log("swapped out")
		@_state = false
		@_killObservations()
		@_controller.hidePlayerGUI()
		#ABoo.NewHeadlessHTML5PlayerSingleton.sharedInstance().setSrc( "" );
	
	flashDidLoad: ( swf ) ->
		@_controller.showPlayerGUI()

		@_createObservervations()
		@_stateMachine.processInputSignal( "ready" )

		# autostart options needed here
		@_headLessSingleton.setSrc( @_mp3URL, true, true )

		# TODO: hold off on this for now.
		# @_headLessSingleton.play( @_mp3URL )

	# TODO: must we tear down observations also
	_createObservervations: () ->
		$actualPlayer = $( @_headLessSingleton._audioPlayingDomNode._observableSwf )
		$actualPlayer.bind( @_watchableEvents, ( e ) =>
			@handleHeadlessFlashPlayerEvent(e.type)
		)
		
	_killObservations: () ->
		$actualPlayer = $( @_headLessSingleton._audioPlayingDomNode._observableSwf )
		$actualPlayer.unbind( @_watchableEvents )
			
	handleHeadlessFlashPlayerEvent: ( eventName ) ->
		#if(eventName!="timeupdate")
		#	console.log("HTML5 player: got an event > " + eventName );
		# TODO: shit shit and bugger!
		#if(eventName!="loadeddata")
		@_stateMachine.processInputSignal( eventName )

	buffered: () ->
		return @_headLessSingleton.buffered()

	loadedDegrees: () ->
		return @_headLessSingleton.loadedDegrees()

	playedDegrees: () ->
		return @_headLessSingleton.playedDegrees()

	play: () ->
		return @_headLessSingleton.play()

	pause: () ->
		return @_headLessSingleton.pause()

	setCurrentTime: ( secs ) ->
		@_headLessSingleton.setCurrentTime(secs)
			
			
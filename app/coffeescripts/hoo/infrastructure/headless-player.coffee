
### abstract superclass for flash and html5
###
ABoo.NewAbstractHeadlessPlayerSingleton = SC.Object.extend
	_audioPlayingDomNode: undefined
	_mp3url: undefined

	# autoload doesn't do much, if you set the src, in html5, it will load
	setSrc: ( mp3Url2, autoload, autoplay ) ->
		HOO_nameSpace.assert( mp3Url2, "you need the mp3 url" )
		HOO_nameSpace.assert( autoload, "html5 autoload stinks concerning the events it sends - just setSrc when you want to load" )

		if @_mp3url != mp3Url2
			@_mp3url = mp3Url2
			console.log( "SRC: " + mp3Url2 )

			if autoplay
				@_audioPlayingDomNode.attrSetter( 'autoplay', 'autoplay' )
				autoload = true

			autoloadsetting = "none"
			if autoload
				autoloadsetting = "auto"
			@_audioPlayingDomNode.attrSetter( 'preload', autoloadsetting )
			@_audioPlayingDomNode.attrSetter( 'src', mp3Url2 )

			# is autoload property imlemented in all flash players?
			if autoload
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
		#console.log("<<<<< playedDegrees: "+ct+" "+duration+" >>>>>> "+playedDegrees )
		return playedDegrees

	# TODO: when you play we have to manually update playcount (first time thru only) - sort out what happens when autoplay
	play: () ->
		@_audioPlayingDomNode.cmd( 'play' )

	pause: () ->
		@_audioPlayingDomNode.cmd( 'pause' )

	currentTime: () ->
		@_audioPlayingDomNode.attrGetter( 'currentTime' )

	setCurrentTime: ( secs ) ->
		if secs != @currentTime()
			@_audioPlayingDomNode.setNodeProperty( 'currentTime', secs )

SC.mixin( ABoo.NewAbstractHeadlessPlayerSingleton, ABoo.SingletonClassMethods )

###
 * Only one of these per page
###
ABoo.NewHTML5HeadlessPlayerSingleton = ABoo.NewAbstractHeadlessPlayerSingleton.extend
	_headlessAudioOb: undefined
	# create the backing html5
	init: () ->
		@_super()
		@_headlessAudioOb = ABoo.HeadlessSharedDomNodeProxy.sharedDivForTag( "audio" )
		@_audioPlayingDomNode = @_headlessAudioOb

	_getTimeRangeEnd: ( timeRanges, timeRangeIndex ) ->
		return timeRanges.end(timeRangeIndex)

SC.mixin( ABoo.NewHTML5HeadlessPlayerSingleton, ABoo.SingletonClassMethods )

###
 * Only one of these per page
###
ABoo.NewFlashHeadlessPlayerSingleton = ABoo.NewAbstractHeadlessPlayerSingleton.extend
	_swfSrc: "HeadlessPlayer/lib/Debug/HeadlessPlayer"
	_headlessFlashOb: undefined
	# create the backing swf
	init: () ->
		@_super()
		flashURL = ABoo.HeadlessSharedFlashObject.uRLForSwf( @_swfSrc )
		# varoius autostart options here - load, play, etc. - cant really use 'em to stay consistent with html5 audio
		@_headlessFlashOb = ABoo.HeadlessSharedFlashObject.sharedSwfForURL( flashURL, '100%', '100%', {autostart:'load'} )
		@_audioPlayingDomNode = @_headlessFlashOb

	_getTimeRangeEnd: ( timeRanges, timeRangeIndex ) ->
		return timeRanges[timeRangeIndex][1]

SC.mixin( ABoo.NewFlashHeadlessPlayerSingleton, ABoo.SingletonClassMethods );


### one of these for each instance of a player
###
ABoo.NewAbstractHeadlessPlayerBackend = SC.Object.extend
	_mp3URL: undefined
	_controller: undefined
	_watchableEvents: 'error emptied loadstart progress loadeddata loadedmetadata durationchange timeupdate canplay canplaythrough waiting play ended abort dataunavailable empty pause ratechange seeked seeking volumechange stalled'
	_stateMachine: undefined
	_state: false
	_headLessSingleton: undefined
	_autoload: true
	_autoplay: false

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
		@_headLessSingleton.setSrc( @_mp3URL, @_autoload, @_autoplay )

		# TODO: hold off on this for now.
		# @_headLessSingleton.play( @_mp3URL )

	# TODO: must we tear down observations also
	_createObservervations: () ->

		$actualPlayer = $( @_headLessSingleton._audioPlayingDomNode._observableSwf )
		$actualPlayer.bind( @_watchableEvents, ( e ) =>
			#console.log("Player Event: "+e.type);
			if( e.type=="timeupdate" and @playedDegrees()==0 )
				console.log("Timeupdate at zero - do we need this to reset clock? like when played thru?")
			else
				run = SC.run.begin()
				@handleHeadlessFlashPlayerEvent(e.type)
				SC.run.end()
		)

	_killObservations: () ->
		$actualPlayer = $( @_headLessSingleton._audioPlayingDomNode._observableSwf )
		$actualPlayer.unbind( @_watchableEvents )

	handleHeadlessFlashPlayerEvent: ( eventName ) ->
		#if(eventName!="timeupdate")
		#console.log("HTML5 player: got an event > " + eventName );
		# TODO: shit shit and bugger!
		#if(eventName!="loadeddata")
		@_stateMachine.processInputSignal( eventName )

	buffered: () ->
		return @_headLessSingleton.buffered()

	duration: () ->
		return @_headLessSingleton.duration()

	loadedDegrees: () ->
		return @_headLessSingleton.loadedDegrees()

	playedDegrees: () ->
		return @_headLessSingleton.playedDegrees()

	play: () ->
		return @_headLessSingleton.play()

	pause: () ->
		return @_headLessSingleton.pause()

	currentTime: () ->
		@_headLessSingleton.currentTime()

	setCurrentTime: ( secs ) ->
		@_headLessSingleton.setCurrentTime(secs)

	setProgressPercent: ( arg ) ->
		newVal = @duration() * arg
		if  newVal >= @buffered()
			newVal = @buffered()-0.5
		#console.log("Set progress "+newVal)
		@setCurrentTime(newVal)

###
 * One of these for each instance on the page
###
ABoo.NewFlashHeadlessPlayerBackend = ABoo.NewAbstractHeadlessPlayerBackend.extend
	_createSingletonPlayer: () ->
		@_headLessSingleton = ABoo.NewFlashHeadlessPlayerSingleton.sharedInstance()

###
 * One of these for each instance on the page
###
ABoo.NewHtml5HeadlessPlayerBackend = ABoo.NewAbstractHeadlessPlayerBackend.extend
	_createSingletonPlayer: () ->
		@_headLessSingleton = ABoo.NewHTML5HeadlessPlayerSingleton.sharedInstance()

### one of these for each instance of a player
###
ABoo.NewAbstractPlayer = ABoo.SCView.extend
	_playerBackend: undefined
	# properties to bind to. neccesary? #
	_ready: false
	_loadProgress: 0
	_playProgress: 0
	_busyFlag: false

	# state machine events #
	ready: () ->
		@set('_ready', true )

	# loading commands #
	cmd_showEmptyLoader: () ->
		jQuery(this).stop()
		@coldSetProperty('_loadProgress', 0)
		@coldSetProperty('_playProgress', 0)
		@set('_busyFlag', false)

	cmd_showStalledLoader: () ->
		# sadly html5 audio will call stalled even after it has fully loaded (Typically on restart). Safari will stall every time at last few percent of very long boos #
		reportedLoadedDegress = @_playerBackend.loadedDegrees()
		if @reportedLoadedDegress>350
			0
			#debugger
		else
			@set('_busyFlag', true)

	cmd_showLoadingLoader: () ->
		@set('_busyFlag', true)

	# Oh, finished event - you were so lovely - but i completely misunderstood you
	# cmd_showFinishedLoader: () ->
	#	@animateLoadProgress( @_loadProgress, 360 )
	#	@set('_busyFlag', false)
	cmd_showResettingLoader: () ->
		#console.log("hello")
		0
	cmd_showErrorLoader: () ->
		@_showDisabled()
		@set('_busyFlag', true)

	# playing commands #
	cmd_showEmptyPlayer: () ->
		@_showDisabled()

	cmd_showStoppedPlayer: () ->
		@_showPlay()

	cmd_showWaitingPlayer: () ->
		@set('_busyFlag', true)
		#console.log("show stalled 2")

	cmd_hideWaitingPlayer: () ->
		@set('_busyFlag', false)
		#console.log("hide stalled 2")

	cmd_showPlayingPlayer: () ->
		@_showPause()

	cmd_showFinishedPlayer: () ->
		jQuery(this).stop()
		@coldSetProperty( '_playProgress', 0 )
		# need this to reset
		@_playerBackend.pause()
		@_playerBackend.setCurrentTime(0)

	cmd_showErrorPlayer: () ->
		@_showDisabled()

	### Button Actions ###
	playClickAction: () ->
		@_playerBackend.play()

	pauseClickAction: () ->
		@_playerBackend.pause()

ABoo.NewAbstractSmallPlayer = ABoo.NewAbstractPlayer.extend
	_hooCanvas: undefined
	_placeHolder$: undefined
	_smallPlayerFrontEnd: undefined

	didInsertElement: () ->
		@_super()
		noJsAnchor$ = @getFirstDomItemOfType("a")
		noJsAnchor$.remove()
		@_placeHolder$ = @getFirstDomItemOfType("img")
		@createPlayerBackend()

	createPlayerBackend: () ->
		###
			This is where you customize...
		###
		0

	# TODO: this is the pits..
	mouseUp: (ev$) ->
		if( @_playerBackend._state==false )
			if( @_placeHolder$ )
				@_playerBackend._attachToPage( @_placeHolder$ )

	# can we draw the playbutton?
	showPlayerGUI: () ->
		#SC.RunLoop.begin()
		@_hooCanvas = ABoo.HooCanvas.newProgrammaticCanvas()
		# remove the image and insert the canvas
		@_hooCanvas.swapInFor( @_placeHolder$ )
		# TODO: not how we will size it, but just to make it visible for now
		@_hooCanvas._setSize( @_placeHolder$.width(), @_placeHolder$.height() )

		# At last! we have found the bit where the whole scheme fails!
		thePlayButtonJson =
			"percentOfCanvas":0.7
			"javascriptActions":
				"mouseClickAction":
					"action_taget":this
					"action_event":["playClickAction", "pauseClickAction"]
					"action_arg":null
					"actionIsAsync":true

		theRadialProgressJson =
			"outerRad":0.95
			"innerRad":0.85

		radialProgress = ABoo.HooRadialProgress.create( {json:theRadialProgressJson, _hooCanvas: @_hooCanvas } )
		playPause = ABoo.HooPlayPauseButton.create( {json:thePlayButtonJson, _hooCanvas: @_hooCanvas } )
		console.warn("created radial "+radialProgress+" and play "+playPause)
		@_smallPlayerFrontEnd = ABoo.SmallPlayerPlayButton.create( {_radialProgress:radialProgress , _playPauseButton:playPause })
		# TODO: dont forget to clean these up
		@addObserver('_loadProgress', radialProgress, radialProgress.loadDidChange )
		@addObserver('_playProgress', radialProgress, radialProgress.playDidChange )
		@addObserver('_busyFlag', radialProgress, radialProgress.busyDidChange )
		@addObserver('_ready', playPause, 'enabledDidChange' )
		radialProgress.setupDidComplete()
		playPause.setupDidComplete()
		@_smallPlayerFrontEnd.setupDidComplete()
		#SC.RunLoop.end()


	hidePlayerGUI: () ->
		if @_hooCanvas?
			radialProgress = @_smallPlayerFrontEnd._radialProgress
			playPause = @_smallPlayerFrontEnd._playPauseButton

			@removeObserver('_loadProgress', radialProgress, radialProgress.loadDidChange )
			@removeObserver('_playProgress', radialProgress, radialProgress.playDidChange )
			@removeObserver('_busyFlag', radialProgress, radialProgress.busyDidChange )
			@removeObserver('_ready', playPause, 'enabledDidChange' )

			# TODO: not sure we will create and destroy the canvas each time
			@_hooCanvas.removeAllSubviews()

			# TODO: put back the image
			@_hooCanvas.swapOutFor( @_placeHolder$ )
			@_hooCanvas = null

	# Beacuse the button action is specified as 'async' it will not automatically show the next state
	# when clicked, we change it when audio player statemachine tells us too
	_showPlay: () ->
		@_smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent( "ev_showState1" )

	_showPause: () ->
		@_smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent( "ev_showState2" )

	_showDisabled: () ->
		@_smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent( "ev_showState1" )

	durationchange: () ->
		#console.log("durationchange" )
		# so, load progress events are sketchy to say the least, attach loadProgress checks everywhere we can..
		@_fakeLoadProgressEvent()

	# seems like we dont always get progress events (html5 audio).. manually check
	_fakeLoadProgressEvent: () ->
		loadedDegrees = @_loadProgress
		reportedLoadedDegress = @_playerBackend.loadedDegrees()
		if( loadedDegrees!=reportedLoadedDegress )
			@animateProperty( '_loadProgress', reportedLoadedDegress, 1000/25*10 )
		@set('_busyFlag', false)

	progressupdate: () ->
		actualLoadedDegrees = @_playerBackend.loadedDegrees()
		if( actualLoadedDegrees>0 )
			@set('_busyFlag', false)
			#console.log("hide stalled")
		@animateProperty( '_loadProgress', actualLoadedDegrees, 1000/25*10 )

	timeupdate: () ->
		@animateProperty( '_playProgress', @_playerBackend.playedDegrees(), 1000/25*10 );
		# TODO: This is horrible
		# @_fakeLoadProgressEvent();

	description: () ->
		return "small player "+@_super()


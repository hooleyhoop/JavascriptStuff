ABoo.AudioPlayerStateMachine = SC.Object.extend

	_loadingController: undefined
	_playingController: undefined
	_controller:undefined

	init: () ->
		@_super()

		# set with init arguments --- @_controller = controller ---

		loadingStateMachineParser = ABoo.HooStateMachineConfigurator.create({config: AudioPlayerStateMachine.loadingStateMachine_config})
		loadingStateMachine = ABoo.HooStateMachine.create( {startState: loadingStateMachineParser.state("st_empty") } )
		@_loadingController = ABoo.HooStateMachine_controller.create( { currentState: loadingStateMachineParser.state("st_empty"), machine: loadingStateMachine, commandsChannel:this } )

		playingStateMachineParser = ABoo.HooStateMachineConfigurator.create({config: AudioPlayerStateMachine.playingStateMachine_config})
		playingStateMachine = ABoo.HooStateMachine.create( {startState: playingStateMachineParser.state("st_empty")} )
		@_playingController = ABoo.HooStateMachine_controller.create( { currentState: playingStateMachineParser.state("st_empty"), machine: playingStateMachine, commandsChannel:this } )

	send: ( command ) ->
		func = @_controller[command.name]

		if func
			func.call(@_controller)
		else
			console.log("Didnt find function "+command.name)

		# Here is one 'special' case, this has to manually trigger complete
		if command.name is "showResettingLoaderCmd"
			@_loadingController.handle( "resetComplete" )
			
	processInputSignal: ( signal ) ->
		# console.log("Incoming >> "+signal );
		switch signal 
			when "ready"
				@_controller.ready()

			# not really sure of the purpose of abort
			when "abort"
				0

			when "error", "dataunavailable", "empty"
				@_loadingController.handle( "error" )
				@_playingController.handle( "error" )

			when "stalled"
				@_loadingController.handle( "stall" )

			when "waiting"
				@_playingController.handle( "wait" )

			when "loadstart", "loadedmetadata"
				@_loadingController.handle( "load" )

			when "durationchange"
				@_loadingController.handle( "load" )
				@_controller.durationchange();

			when "progress"
				@_loadingController.handle( "load" )
				@_controller.progressupdate();

			when "canplay", "canplaythrough"
				@_loadingController.handle( "load" )
				@_playingController.handle( "canPlay" )

			when "loadeddata"
				@_loadingController.handle( "loadComplete" )

			when "emptied"
				@_loadingController.handle( "reset" )
				@_playingController.handle( "reset" )

			when "timeupdate"
				@_playingController.handle( "timeupdate" )
				@_controller.timeupdate()

			when "play"
				@_playingController.handle( "play" )

			when "ended"
				@_playingController.handle( "ended" )

			when "pause"
				@_playingController.handle( "stop" )

			else throw("** Unknown Signal ** -"+signal)
			
ABoo.AudioPlayerStateMachineClassMethods = SC.Mixin.create
	loadingStateMachine_config:
		"states": [
			"st_empty"
			"st_stalled"
			"st_loading"
			"st_loaded"
			"st_resetting"
			"st_error"
		]
		"events": [
			"ev_error"
			"ev_reset"
			"ev_load"
			"ev_loadComplete"
			"ev_resetComplete"
			"ev_stall"
		]
		"commands": [
			"cmd_showEmptyLoader"
			"cmd_showStalledLoader"
			"cmd_showLoadingLoader"
			"cmd_showFinishedLoader"
			"cmd_showResettingLoader"
			"cmd_showErrorLoader"
		]
		"transitions": [
			{"state": "st_empty", "event": "ev_load", "nextState": "st_loading"}

			{"state": "st_loading", "event": "ev_stall", "nextState": "st_stalled"}
			{"state": "st_loading", "event": "ev_error", "nextState": "st_error"}
			{"state": "st_loading", "event": "ev_loadComplete", "nextState": "st_loaded"}
			{"state": "st_loading", "event": "ev_reset", "nextState": "st_resetting"}

			{"state": "st_stalled", "event": "ev_load", "nextState": "st_loading"}
			{"state": "st_stalled", "event": "ev_error", "nextState": "st_error"}
			{"state": "st_stalled", "event": "ev_reset", "nextState": "st_resetting"}

			{"state": "st_loaded", "event": "ev_reset", "nextState": "st_resetting"}
			{"state": "st_empty", "event": "ev_reset", "nextState": "st_resetting"}
			{"state": "st_error", "event": "ev_reset", "nextState": "st_resetting"}
			{"state": "st_resetting", "event": "ev_resetComplete", "nextState": "st_empty"}
		]
		"actions": [
			{"state": "st_empty", "entryAction": "cmd_showEmptyLoader", "exitAction": null }
			{"state": "st_stalled", "entryAction": "cmd_showStalledLoader", "exitAction": null }
			{"state": "st_loading", "entryAction": "cmd_showLoadingLoader", "exitAction": null }
			{"state": "st_loaded", "entryAction": "cmd_showFinishedLoader", "exitAction": null }
			{"state": "st_resetting", "entryAction": "cmd_showResettingLoader", "exitAction": null }
			{"state": "st_error", "entryAction": "cmd_showErrorLoader", "exitAction": null }
		]
	
		playingStateMachine_config:
			
			"states": [
				"st_empty"
				"st_stopped"
				"st_waiting"
				"st_playing"
				"st_finished"
				"st_error"
			]

			"events": [
				"ev_canPlay"
				"ev_play"
				"ev_timeupdate"
				"ev_wait"
				"ev_stop"
				"ev_ended"
				"ev_error"
				"ev_reset"
			]

			"commands": [
				"cmd_showEmptyPlayer"
				"cmd_showStoppedPlayer"
				"cmd_showWaitingPlayer"
				"cmd_hideWaitingPlayer"
				"cmd_showPlayingPlayer"
				"cmd_showFinishedPlayer"
				"cmd_showErrorPlayer"
			],

			"transitions": [
				{"state": "st_empty", "event": "ev_canPlay", "nextState": "st_stopped"}
				{"state": "st_empty", "event": "ev_error", "nextState": "st_error"}
				{"state": "st_empty", "event": "ev_play", "nextState": "st_playing"}

				{"state": "st_stopped", "event": "ev_play", "nextState": "st_playing"}
				{"state": "st_stopped", "event": "ev_error", "nextState": "st_error"}
				{"state": "st_stopped", "event": "ev_reset", "nextState": "st_empty"}

				{"state": "st_playing", "event": "ev_error", "nextState": "st_error"}
				{"state": "st_playing", "event": "ev_stop", "nextState": "st_stopped"}
				{"state": "st_playing", "event": "ev_reset", "nextState": "st_empty"}
				{"state": "st_playing", "event": "ev_wait", "nextState": "st_waiting"}
				{"state": "st_playing", "event": "ev_ended", "nextState": "st_finished"}

				{"state": "st_waiting", "event": "ev_error", "nextState": "st_error"}
				{"state": "st_waiting", "event": "ev_stop", "nextState": "st_stopped"}
				{"state": "st_waiting", "event": "ev_timeupdate", "nextState": "st_playing"}
				{"state": "st_waiting", "event": "ev_reset", "nextState": "st_empty"}

				{"state": "st_finished", "event": "ev_stop", "nextState": "st_stopped"}
				{"state": "st_error", "event": "ev_reset", "nextState": "st_empty"}
			]

			"actions": [
				{"state": "st_empty", "entryAction": "cmd_showEmptyPlayer", "exitAction": null }
				{"state": "st_stopped", "entryAction": "cmd_showStoppedPlayer", "exitAction": null }
				{"state": "st_waiting", "entryAction": "cmd_showWaitingPlayer", "exitAction": "cmd_hideWaitingPlayer" }
				{"state": "st_playing", "entryAction": "cmd_showPlayingPlayer", "exitAction": null }
				{"state": "st_finished", "entryAction": "cmd_showFinishedPlayer", "exitAction": null }
				{"state": "st_error", "entryAction": "cmd_showErrorPlayer", "exitAction": null }
			]

SC.mixin( ABoo.AudioPlayerStateMachine, ABoo.AudioPlayerStateMachineClassMethods )			
			
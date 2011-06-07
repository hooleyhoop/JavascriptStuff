ABoo.HooThreeStateItem = ABoo.HooWidget.extend

	_buttonSM: undefined
	_graphic: undefined
	_clickableItem$: undefined
	_target:undefined
	_action: undefined
	_actionArg: undefined
	_isAsync: undefined

	init:() -> # _graphic
		@_super()
		@_createSM()
		@_graphic.showDisabledButton()
		@_listenerDebugger = ABoo.ActiveListenerDebugger.create()
		
	_createSM: () ->
		@_buttonSM = ABoo.ThreeStateButtonStateMachine.create( { _controller: @ } )

	setButtonTarget: ( target, action, arg, isAsync ) ->
		@_target = target
		@_action = action
		@_actionArg = arg
		@_isAsync = isAsync

	# input
	# - ev_showState1, ev_disable, ev_error
	sendEvent: ( ev ) ->
		@_buttonSM.processInputSignal( ev )

	# State machine callbacks
	cmd_enableButton: () ->
		@_listenerDebugger.addListener( @_clickableItem$, 'mousedown', @, @_mouseDown )

	cmd_disableButton: () ->
		@_listenerDebugger.removeListener( @_clickableItem$, 'mousedown', @, @_mouseDown )
		@_graphic.showDisabledButton();

	cmd_showMouseUp1: () ->
		@_graphic.showMouseUp1State()

	cmd_showMouseDown1: () ->
		@_graphic.showMouseDown1State()

	cmd_showMouseDownOut1: () ->
		@_graphic.showMouseUp1State()

	cmd_fireButtonAction1: () ->
		@_fire("ev_showState1" )

	_fire: (nextState) ->

		###
		TODO:
		how do we handle toggle button?
		how do we handle async actions?
		how do we go back to the correct state?
		###

		completionCallback = () =>
			@sendEvent( nextState )

		onCompleteStuffHash = {onCompleteTarget: @, onCompleteAction: completionCallback}

		if @_target
			#@_delegate.fireAction();
			@_action.call( @_target, @_actionArg, onCompleteStuffHash )

		if @_isAsync==false 
			completionCallback()

	cmd_abortClickAction: () ->
		@sendEvent( "ev_clickAbortCompleted" )

	_mouseDown: (e) ->

		# cant get $(window).mouseup to work on IE7 so using document instead
		@_listenerDebugger.addListener( $(document), 'mouseup', @, @_mouseStageUp )
		@_clickableItem$.unselectable = "on"
		@_clickableItem$.onselectstart = () ->
			return false
		
		@_listenerDebugger.addListener( @_clickableItem$, 'mouseleave', @, @_mouseRollOutHandler )
		@_listenerDebugger.addListener( @_clickableItem$, 'mouseenter', @, @_mouseRollOverHandler )

		@sendEvent( "ev_buttonPressed" )
		e.preventDefault()
		
	_mouseStageUp: (e) ->
		@_listenerDebugger.removeListener( $(window), 'mouseup', @, @_mouseStageUp )
		@_listenerDebugger.removeListener( @_clickableItem$, 'mouseleave', @, @_mouseRollOutHandler )
		@_listenerDebugger.removeListener( @_clickableItem$, 'mouseenter', @, @_mouseRollOverHandler )

		@sendEvent("ev_buttonReleased")
		e.preventDefault()

	_mouseRollOutHandler: (e) ->
		@sendEvent("ev_mouseDraggedOutside")

	_mouseRollOverHandler: (e) ->
		@sendEvent("ev_mouseDraggedInside")

	currentStateName: () ->
		return @_buttonSM.currentStateName()

	setCurrentStateName: (arg) ->
		return @_buttonSM.processInputSignal( arg )


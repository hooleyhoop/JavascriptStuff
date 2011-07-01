
###
###
ABoo.HooStateMachine_command = SC.Object.extend
	_name: undefined

###
###
ABoo.HooStateMachine_event = SC.Object.extend
	_name: undefined

###
###
ABoo.HooStateMachine_state = SC.Object.extend
	_name:			undefined
	_entryActions:	undefined
	_exitActions:	undefined
	_transitions:	undefined
	_parent:		undefined

	init: () ->
		@_super()
		@_entryActions = new Array()
		@_exitActions = new Array()
		@_transitions = new Object()

	addTransition: ( event, targetState ) ->
		unless targetState? and event?
			alert("Error: invalid params for HooStateMachine_state")

		t = ABoo.HooStateMachine_transition.create( {_source:@, _trigger:event, _target:targetState} )
		@_transitions[event._name] = t

	removeAllTransitions: () ->
		@_transitions = new Object()

	addEntryAction: ( cmd ) ->
		@_entryActions.push(cmd)

	addExitAction: ( cmd ) ->
		@_exitActions.push(cmd)

	# NOT yet updated for HSM
	#getAllTargets: () ->
	#	result = new Array()
	#	$.each( transitions, function(index, value) {
	#		alert(index + ': ' + value);
	#		result.push( value._target );
	#	});
	#	return result;

	# hsm
	hasTransition: ( eventName ) ->
		hasT = @_transitions.hasOwnProperty( eventName )
		if hasT==false and @_parent?
			hasT = @_parent.hasTransition(eventName)
		return hasT

	# hsm
	transitionForEvent: ( eventName ) ->
		transition = @_transitions[eventName]
		if !transition? and @_parent?
			transition = @_parent.transitionForEvent(eventName)
		return transition

	# hsm
	targetState: ( eventName ) ->
		transition = @transitionForEvent(eventName)
		tState = transition._target
		return tState

	executeEntryActions: ( commandsChannel ) ->
		commandsChannel.send value for value in @_entryActions
		return true

	executeExitActions: ( commandsChannel ) ->
		commandsChannel.send value for value in @_exitActions
		return true

	hierachyList: () ->
		hierachy = new Array()
		head = @
		while( head? )
			hierachy.unshift(head); # because insertAtBeginning would be too helpful
			head = head._parent;
		return hierachy

###
	Transition
###
ABoo.HooStateMachine_transition = SC.Object.extend
	_source: undefined
	_trigger: undefined
	_target: undefined

	getEventName: () ->
		return @_trigger._name

###
	HooStateMachineConfigurator
###
ABoo.HooStateMachineConfigurator = SC.Object.extend
	_config: undefined
	_states: undefined
	_events: undefined
	_commands: undefined
	_resetEvents:undefined

	init: ( ) -> # init never has args
		@_super()
		@_states = new Object
		@_events = new Object
		@_commands = new Object
		@_resetEvents = new Array()

		@parseStates()
		@parseEvents()
		@parseCommands()
		@parseTransitions()
		@parseActions()
		@parseResetEvents()

	parseStates: () ->
		for value in @_config['states']
			stateName = value
			parentState = null
			if $.isArray(value)
				stateName = value[0]
				parentStateName = value[1]
				parentState = @_states[parentStateName]
				unless parentState?
					alert("Error: Parent state doesnt exist")

			newState = ABoo.HooStateMachine_state.create( {_name: stateName, _parent: parentState} )
			@_states[stateName] = newState

	parseEvents: () ->
		for value in @_config['events']
			newEvent = ABoo.HooStateMachine_event.create( {_name: value} )
			@_events[value] = newEvent

	parseResetEvents: () ->
		for value in @_config['resetEvents']
			ev = @_events[value]
			alert("Error! is reset event a real event?") unless ev
			@_resetEvents.push( ev )

	parseCommands: () ->
		for value in @_config['commands']
			newCommand = ABoo.HooStateMachine_command.create( {_name: value} )
			@_commands[value] = newCommand;

	parseTransitions: () ->
		for value in @_config['transitions']
			stateName = value['state']
			eventName = value['event']
			nextStateName = value['nextState']
			@_states[stateName].addTransition( @_events[eventName], @_states[nextStateName] )

	parseActions: () ->
		for value in @_config['actions']
			if not value? then return

			stateName = value['state']
			entryAction = value['entryAction']
			exitAction = value['exitAction']
			state = @_states[stateName]

			if entryAction?
				entryCmd = @_commands[entryAction]
				# alert("state > "+state+" entry cmd "+entryCmd);
				state.addEntryAction( entryCmd )

			if exitAction?
				exitCmd = @_commands[exitAction]
				# alert("state > "+state+" exit cmd "+entryCmd);
				state.addExitAction( exitCmd )

	state: ( key ) ->
		return @_states[key]

###
	HooStateMachine
###
ABoo.HooStateMachine = SC.Object.extend
	_startState:		undefined
	_resetEvents:		undefined

	init: () ->
		@_super()
		@_resetEvents or= new Array()

	#getStates: function() {
	#	var result = new Array()
	#	@_collectStates( result, @_startState )
	#	return result

	#_collectStates: function( result, s ) {
	#	if( $.inArray(s, result) )
	#		return;
	#	result.push(s);
	#	var allTargets = s.getAllTargets();
	#	$.each( allTargets, function(index, value) {
	#		collectStates(result, value);
	#	});
	#}

	addResetEvents: ( events ) ->
		@_resetEvents.push value for value in events
		return true

	isResetEvent: ( eventName ) ->
		resetEventNames = @resetEventNames()
		result = $.inArray( eventName, resetEventNames )
		return result > -1;

	resetEventNames: () ->
		eventNames = (event._name for event in @_resetEvents)


###
 * Communicates with devices by receiving event messages and sending command messages.
 * These are both four-letter codes sent through the communication channels.
###
ABoo.HooStateMachine_controller = SC.Object.extend
	_currentState: undefined
	_machine: undefined
	_commandsChannel: undefined

	handle: ( eventName, e, f ) ->
		nextState = null
		# save a useful reference to the jquery event (for mouse pos and stuff)
		if e?
			# console.log("saving e "+eventName+" "+e.pageX); // buttonPressed buttonReleased
			@_commandsChannel.lastWindowEvent = e
		if @_currentState.hasTransition(eventName)
			nextState = @_currentState.targetState(eventName)
		else if @_machine.isResetEvent(eventName)
			console.log("Found reset event")
			nextState = @_machine._startState
		# ignore unknown events
		#else
		#	console.log("** Unknown event "+eventName+" for state: "+@_currentState._name )
		if nextState?
			@_transitionTo( nextState )

	_transitionTo: ( targetState ) ->
		thisParentList = @_currentState.hierachyList()
		thatParentList = targetState.hierachyList()

		# eliminate shared parents from the front of the chain - the ones left in thisParentList are the ones we are exiting, the ones left in thatParentList are the ones we are entering
		shortestLength = if (thisParentList.length < thatParentList.length) then thisParentList.length else thatParentList.length
		sharedparentsIndex = -1
		i = 0
		while i < shortestLength
			if thisParentList[i] == thatParentList[i]
				sharedparentsIndex = i++
			else
				break
		if sharedparentsIndex > -1
			thisParentList.splice(0,sharedparentsIndex+1)
			thatParentList.splice(0,sharedparentsIndex+1)

		thisParentList.reverse()

		for element in thisParentList
			element.executeExitActions( @_commandsChannel )

		@_currentState = targetState

		for element in thatParentList
			element.executeEntryActions( @_commandsChannel )

		return true

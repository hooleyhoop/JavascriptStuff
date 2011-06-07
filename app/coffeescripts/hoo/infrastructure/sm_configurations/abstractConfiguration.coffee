ABoo.AbstractConfiguration = SC.Object.extend
	_stateMachineController: undefined
	_controller: undefined

	init: () -> # _controller 
		@_super()
		@setupStateMachines()

	setupStateMachines: () ->
		stateMachine_config = @sm_config()
		stateMachineParser = ABoo.HooStateMachineConfigurator.create({ _config: stateMachine_config })

		#assume first state is start state
		startState = stateMachineParser.state( stateMachine_config['states'][0] );
		stateMachineInstance = ABoo.HooStateMachine.create( {_startState: startState, _resetEvents:stateMachineParser._resetEvents } )
		@_stateMachineController = ABoo.HooStateMachine_controller.create( {_currentState:startState, _machine:stateMachineInstance, _commandsChannel:this })

	# input
	processInputSignal: ( signal ) ->
		@_stateMachineController.handle(signal)

	# output from sm
	send: ( command ) ->
		func = @_controller[command._name]
		if func?
			func.call(@_controller)
		else
			console.warn("Didnt find function " + command._name)

	sm_config: () ->
		debugger
		return null

	currentStateName: () ->
		return @_stateMachineController._currentState._name

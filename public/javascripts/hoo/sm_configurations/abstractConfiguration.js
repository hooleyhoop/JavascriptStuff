
AbstractConfiguration = SC.Object.extend({

	_stateMachineController:undefined,
	_controller:undefined,

	init: function( /* _controller */ ) {
		arguments.callee.base.apply( this, arguments );
		this.setupStateMachines();
	},

	setupStateMachines: function() {

		var stateMachine_config = this.sm_config();
		var stateMachineParser = HooStateMachineConfigurator.create({ config: stateMachine_config });

		// assume first state is start state
		var startState = stateMachineParser.state( stateMachine_config['states'][0] );
		var stateMachineInstance = HooStateMachine.create( {startState: startState, resetEvents:stateMachineParser._resetEvents } );
		this._stateMachineController = HooStateMachine_controller.create( { currentState:startState, machine:stateMachineInstance, commandsChannel:this });
	},

	// input
	processInputSignal: function( signal ) {
		this._stateMachineController.handle(signal);
	},

	// output from sm
	send: function( command ) {

		var func = this._controller[command.name];
		if(func) {
			func.call(this._controller);
		} else {
			console.warn("Didnt find function "+command.name);
		}
	},

	sm_config: function() {
		debugger;
		return null;
	},

	currentStateName: function() {
		return this._stateMachineController.currentState.name;
	}

});


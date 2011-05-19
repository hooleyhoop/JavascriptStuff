/* S T A T E   M A C H I N E */
HooStateMachine_abstractEvent = SC.Object.extend({
	name: undefined
});

HooStateMachine_command = HooStateMachine_abstractEvent.extend({
});

HooStateMachine_event = HooStateMachine_abstractEvent.extend({
});

HooStateMachine_state = SC.Object.extend({

	name:			undefined,
	entryActions:	undefined,
	exitActions:	undefined,
	transitions:	undefined,
	_parent:		undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
		this.entryActions = new Array();
		this.exitActions = new Array();
		this.transitions = new Object();
	},

	addTransition: function( event, targetState ) {
		if( targetState==null || event==null )
			alert("Error: invalid params for HooStateMachine_state");
		var t = HooStateMachine_transition.create( {source:this, trigger:event, target:targetState} );
		this.transitions[event.name] = t;
	},

	removeAllTransitions: function() {
		this.transitions = new Object();
	},

	addEntryAction: function( cmd ) {
		this.entryActions.push(cmd);
	},
	addExitAction: function( cmd ) {
		this.exitActions.push(cmd);
	},

	// NOT yet updated for HSM
	getAllTargets: function() {
		var result = new Array();
		$.each( transitions, function(index, value) {
			alert(index + ': ' + value);
			result.push( value.target );
		});
		return result;
	},

	//hsm
	hasTransition: function( eventName ) {
		var hasT = this.transitions.hasOwnProperty( eventName );
		if( hasT==false && this._parent!=null )
			hasT = this._parent.hasTransition(eventName);
		return hasT;
	},

	// hsm
	transitionForEvent: function( eventName ) {
		var transition = this.transitions[eventName];
		if( transition==null && this._parent!=null )
			transition = this._parent.transitionForEvent(eventName);
		return transition;
	},

	// hsm
	targetState: function( eventName ) {
		var transition = this.transitionForEvent(eventName);
		var tState = transition.target;
		return tState;
	},

	executeEntryActions: function( commandsChannel ) {

		$.each( this.entryActions, function(index, value) {
			commandsChannel.send( value );
		});
	},

	executeExitActions: function( commandsChannel ) {

		$.each( this.exitActions, function(index, value) {
			commandsChannel.send( value );
		});
	},

	hierachyList: function() {
		var hierachy = new Array();
		var head = this;
		while( head != null ){
			hierachy.unshift(head); // because insertAtBeginning would be too helpful
			head = head._parent;
		}
		return hierachy;
	}
});

HooStateMachine_transition = SC.Object.extend({

	source: undefined,
	trigger: undefined,
	target: undefined,

	getEventName: function() {
		return this.trigger.name;
	}
});

HooStateMachineConfigurator = SC.Object.extend({

	config: undefined,
	_states: undefined,
	_events: undefined,
	_commands: undefined,
	_resetEvents:undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
		this._states = new Object;
		this._events = new Object;
		this._commands = new Object;
		this._resetEvents = new Array();

		this.parseStates();
		this.parseEvents();
		this.parseCommands();
		this.parseTransitions();
		this.parseActions();
		this.parseResetEvents();
	},

	parseStates: function() {
		var self = this;
		$.each( this.config['states'], function( index, value ){
			var stateName = value;
			var parentState = null;
			if( $.isArray(value) ) {
				stateName = value[0];
				var parentStateName = value[1];
				parentState = self._states[parentStateName];
				if( parentState==null )
					alert("Error: Parent state doesnt exist");
			}
			var newState = HooStateMachine_state.create( {name: stateName, _parent: parentState} );
			self._states[stateName] = newState;
		});
	},

	parseEvents: function() {
		var self = this;
		$.each( this.config['events'], function( index, value ){
			var newEvent = HooStateMachine_event.create( {name: value} );
			self._events[value] = newEvent;
		});
	},

	parseResetEvents: function() {
		var self = this;
		$.each( this.config['resetEvents'], function( index, value ){
			var ev = self._events[value];
			if( ev===null )
				alert("Error! is reset event a real event?");
			self._resetEvents.push( ev );
		});
	},

	parseCommands: function() {
		var self = this;
		$.each( this.config['commands'], function( index, value ){
			var newCommand = HooStateMachine_command.create( {name: value} );
			self._commands[value] = newCommand;
		});
	},

	parseTransitions: function() {
		var self = this;
		$.each( this.config['transitions'], function( index, value ){
			var stateName = value['state'];
			var eventName = value['event'];
			var nextStateName = value['nextState'];
			self._states[stateName].addTransition( self._events[eventName], self._states[nextStateName] );
		});
	},

	parseActions: function() {

		var self = this;
		$.each( this.config['actions'], function( index, value ){

			if(!value)
				return;

			var stateName = value['state'];
			var entryAction = value['entryAction'];
			var exitAction = value['exitAction'];
			var state = self._states[stateName];

			if(entryAction!=null) {
				var entryCmd = self._commands[entryAction];
				// alert("state > "+state+" entry cmd "+entryCmd);
				state.addEntryAction( entryCmd );
			}

			if(exitAction!=null) {
				var exitCmd = self._commands[exitAction];
				// alert("state > "+state+" exit cmd "+entryCmd);
				state.addExitAction( exitCmd );
			}
		});
	},

	state: function( key ) {
		return this._states[key];
	}
});

HooStateMachine = SC.Object.extend({

	startState:			undefined,
	resetEvents:		undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
		this.resetEvents = this.resetEvents || new Array();
	},

	getStates: function() {
		var result = new Array();
		this.collectStates( result, startState );
		return result;
	},

	// private
	collectStates: function( result, s ) {
		if( $.inArray(s, result) )
			return;
		result.push(s);
		var allTargets = s.getAllTargets();
		$.each( allTargets, function(index, value) {
			collectStates(result, value);
		});
	},

	addResetEvents: function( events ) {
		var self = this;
		$.each( events, function(index, value) {
			self.resetEvents.push(value);
		});
	},

	isResetEvent: function( eventName ) {
		var resetEventNames = this.resetEventNames();
		var result = $.inArray( eventName, resetEventNames );
		return result > -1;
	},

	resetEventNames: function() {
		var result = new Array();
		$.each( this.resetEvents, function(index, value) {
			result.push( value.name );
		});
		return result;
	}
});

/*
 * Communicates with devices by receiving event messages and sending command messages.
 * These are both four-letter codes sent through the communication channels.
*/
HooStateMachine_controller = SC.Object.extend({

	currentState: undefined,
	machine: undefined,
	commandsChannel: undefined,

	handle: function( eventName, e, f ) {

		var nextState = null;

		// save a useful reference to the jquery event (for mouse pos and stuff)
		if(e){
		//console.log("saving e "+eventName+" "+e.pageX); // buttonPressed buttonReleased
			this.commandsChannel.lastWindowEvent = e;
		}

		if( this.currentState.hasTransition(eventName) ){
			nextState = this.currentState.targetState(eventName)

		} else if( this.machine.isResetEvent(eventName) ) {
			console.log("Found reset event");
			nextState = this.machine.startState;

		// ignore unknown events
		} else {
			// console.log("unknown event "+eventName );
		}

		if(nextState) {
			this._transitionTo( nextState );
		}
	},

	_transitionTo: function( targetState ) {

		var self = this;
		var thisParentList = this.currentState.hierachyList();
		var thatParentList = targetState.hierachyList();

		// eliminate shared parents from the front of the chain - the ones left in thisParentList are the ones we are exiting, the ones left in thatParentList are the ones we are entering
		var shortestLength = thisParentList.length < thatParentList.length ? thisParentList.length : thatParentList.length;
		var sharedparentsIndex = -1;
		for( var i=0; i<shortestLength; i++ ) {
			if(thisParentList[i]==thatParentList[i])
				sharedparentsIndex = i;
			else
				break;
		}
		if(sharedparentsIndex > -1) {
			thisParentList.splice(0,sharedparentsIndex+1);
			thatParentList.splice(0,sharedparentsIndex+1);
		}

		thisParentList.reverse();
		$.each( thisParentList, function(index, element) {
			element.executeExitActions( self.commandsChannel );
		});

		this.currentState = targetState;

		$.each( thatParentList, function(index, element) {
			element.executeEntryActions( self.commandsChannel );
		});
	 }
});



/* S T A T E   M A C H I N E */

HooStateMachine_testCommandChannel = SC.Object.extend({

	send: function( command ) {
		alert( command.name );
	}
});

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

	getAllTargets: function() {
		var result = new Array();
		$.each( transitions, function(index, value) {
			alert(index + ': ' + value);
			result.push( value.target );
		});
		return result;
	},

	hasTransition: function( eventName ) {
		return this.transitions.hasOwnProperty( eventName );
	},

	targetState: function( eventName ) {
		return this.transitions[eventName].target;
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

HooStateMachine = SC.Object.extend({

	startState:			undefined,
	resetEvents:		undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
		this.resetEvents = new Array();
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
		return this.resetEventNames().hasOwnProperty( eventName );
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
			nextState = this.machine.startState

		// ignore unknown events
		} else {
			// console.log("unknown event "+eventName );
		}

		if(nextState) {
			this._transitionTo( nextState );
		}
	},

	_transitionTo: function( targetState ) {
		 this.currentState = targetState;
		 targetState.executeEntryActions( this.commandsChannel );
	 }
});

// Lets kick off state machine tests
function testFSM() {
	// She has a secret compartment in her bedroom that is normally locked and concealed.
	// To open it, she has to close the door, then open the second drawer in her chest and turn her bedside light on—in either order.
	// Once these are done, the secret panel is unlocked for her to open.
	// The controller Communicates with devices by receiving event messages and sending command messages.
	// These are both four-letter codes sent through the communication channels.

	var doorClosed_event		= HooStateMachine_event.create( {name: "doorClosed"} );
	var drawerOpened_event		= HooStateMachine_event.create( {name: "drawerOpened"} );
	var lightOn_event			= HooStateMachine_event.create( {name: "lightOn"} );
	var doorOpened_event		= HooStateMachine_event.create( {name: "doorOpened"} );
	var panelClosed_event		= HooStateMachine_event.create( {name: "panelClosed"} );

	var unlockPanelCmd 			= HooStateMachine_command.create( {name: "unlockPanel"} );
	var lockPanelCmd 			= HooStateMachine_command.create( {name: "lockPanel"} );
	var lockDoorCmd 			= HooStateMachine_command.create( {name: "lockDoor"} );
	var unlockDoorCmd 			= HooStateMachine_command.create( {name: "unlockDoor"} );

	var idle_state				= HooStateMachine_state.create( {name: "idle" });
	var active_state			= HooStateMachine_state.create( {name: "active" });
	var waitingForLight_state	= HooStateMachine_state.create( {name: "waitingForLight" });
	var waitingForDrawer_state	= HooStateMachine_state.create( {name: "waitingForDrawer" });
	var unlockedPanel_state		= HooStateMachine_state.create( {name: "unlockedPanel" });

	var stateMachineInstance = HooStateMachine.create( {startState: idle_state} );

	idle_state.addTransition( doorClosed_event, active_state );
	idle_state.addEntryAction( unlockDoorCmd );
	idle_state.addEntryAction( lockPanelCmd );

	active_state.addTransition( drawerOpened_event, waitingForLight_state );
	active_state.addTransition( lightOn_event, waitingForDrawer_state );

	waitingForLight_state.addTransition( lightOn_event, unlockedPanel_state );

	waitingForDrawer_state.addTransition( drawerOpened_event, unlockedPanel_state );

	unlockedPanel_state.addEntryAction( unlockPanelCmd );
	unlockedPanel_state.addEntryAction( lockDoorCmd );
	unlockedPanel_state.addTransition( panelClosed_event, idle_state );

	var resetEvents = new Array();
	resetEvents.push( doorOpened_event );
	stateMachineInstance.addResetEvents( resetEvents );

	var testReciever = HooStateMachine_testCommandChannel.create();
	var controller = HooStateMachine_controller.create( { currentState: idle_state, machine: stateMachineInstance, commandsChannel: testReciever } );

	controller.handle( "doorClosed" );
	controller.handle( "drawerOpened" );
	controller.handle( "lightOn" );
};


// rework this with mixins!
HooThreeStateItem = SC.Object.extend({

	_fsm_controller: undefined,

	/* States */
	_disabled_state:			undefined,
	_enabled_state:				undefined,	// just passes thru here
	_active_state1:				undefined,
	_active_down_state1:		undefined,

	// the clicked state is needed bacuse we dont want to return the button to normal
	// on mouse up we want to hold it in clicked state until the action is complete
	_clicked_state1:			undefined,
	_abortClick_state1:			undefined,

	/* Events - so these are like, Class variables? */
	_enable_event:				HooStateMachine_event.create( {name: "enable"} ),
	_enabledSuccessfully_event:	HooStateMachine_event.create( {name: "enabledSuccessfully"} ),
	_buttonPressed_event:		HooStateMachine_event.create( {name: "buttonPressed"} ),
	_buttonReleased_event:		HooStateMachine_event.create( {name: "buttonReleased"} ),
	_mouseDraggedOut_event:		HooStateMachine_event.create( {name: "mouseDraggedOutside"} ),
	_clickComplete_event:		HooStateMachine_event.create( {name: "clickActionCompleted"} ),
	_clickAbortComplete_event:	HooStateMachine_event.create( {name: "clickAbortCompleted"} ),

	/* Commands */
	_enableButtonCmd:			HooStateMachine_command.create( {name: "enableButton"} ),
	_showMouseUpCmd1:			HooStateMachine_command.create( {name: "showMouseUp1"} ),
	_showMouseDownCmd1: 		HooStateMachine_command.create( {name: "showMouseDown1"} ),
	_fireButtonActionCmd1:		HooStateMachine_command.create( {name: "fireButtonAction1"} ),
	_abortClickActionCmd:		HooStateMachine_command.create( {name: "abortClickAction"} ),

	_delegate:					undefined,
	_initialState:				undefined,

	lastWindowEvent:			undefined,

	/* Overide this is more complex buttons */
	_setupStateMachine: function( initialState ) {

		this._initialState = initialState;

		/* States TODO: Couldn't i just use strings instead of these objects? */
		this._disabled_state		= HooStateMachine_state.create( {name: "disabled" });
		this._enabled_state			= HooStateMachine_state.create( {name: "enabled" });
		this._active_state1			= HooStateMachine_state.create( {name: "active1" });
		this._active_down_state1	= HooStateMachine_state.create( {name: "active_down1" });
		this._clicked_state1		= HooStateMachine_state.create( {name: "clicked1" });
		this._abortClick_state1		= HooStateMachine_state.create( {name: "abort-click1" });

		/* Transitions */
		this._disabled_state.addTransition( this._enable_event, this._enabled_state );
		this._enabled_state.addTransition( this._enabledSuccessfully_event, this._active_state1 );
		this._active_state1.addTransition( this._buttonPressed_event, this._active_down_state1 );
		this._active_down_state1.addTransition( this._buttonReleased_event, this._clicked_state1 );

		this._active_down_state1.addTransition( this._mouseDraggedOut_event, this._abortClick_state1 );
		this._clicked_state1.addTransition( this._clickComplete_event, this._active_state1 );

		/* This needs overiding in button 2 - how to handle ? */
		this._abortClick_state1.addTransition( this._clickAbortComplete_event, this._active_state1 );

		this._enabled_state.addEntryAction( this._enableButtonCmd );
		this._active_state1.addEntryAction( this._showMouseUpCmd1 );
		this._active_down_state1.addEntryAction( this._showMouseDownCmd1 );
		this._clicked_state1.addEntryAction( this._fireButtonActionCmd1 );
		this._abortClick_state1.addEntryAction( this._abortClickActionCmd );

		/* set up our button statemachine */
		var stateMachineInstance = HooStateMachine.create( {startState: this._disabled_state} );
		this._fsm_controller = HooStateMachine_controller.create( { currentState: this._disabled_state, machine: stateMachineInstance, commandsChannel: this } );
	},

	/* Incoming commands from the state machine */
	send: function( command ) {
		this[command.name](); // interpet the command as an instance method and call it
	},

	setInitialState: function( shouldStartActive ) {
		// regardless, begin in the disabled state
		this.temporarySetEnabledState( 0, false );
		// if enabled? is not observing anything, assume we should advance to the enabled state automatically
		if(shouldStartActive)
			this._fsm_controller.handle( "enable" );
	},

	showMouseDownState: function( state ) {
		$(window).bind( 'mouseup', {target:this._fsm_controller, action:'handle', arg:"buttonReleased" }, this._delegate.eventTrampoline );
		this._delegate.showMouseDownState(state);
	},

	showMouseUpState: function( state ) {
		$(window).unbind( 'mouseup' );
		this._delegate.showMouseUpState(state);
	},

	showMouseDown1: function() {
		this.showMouseDownState(2);
	},

	showMouseUp1: function() {
		this.showMouseUpState(1);
	},

	abortClickAction: function() {
		// on complete set the button state back to normal
		this._fsm_controller.handle( "clickAbortCompleted" );
	},

	/* This should only be called once, when it enters the enabled state */
	enableButton: function( state ) {

		var button = this._delegate.getClickableItem();
		if( button ) {
			button.bind( 'mousedown', {target:this._fsm_controller, action:'handle', arg:"buttonPressed" }, this._delegate.eventTrampoline );
			button.bind( 'mouseleave', {target:this._fsm_controller, action:'handle', arg:"mouseDraggedOutside" }, this._delegate.eventTrampoline );
		}

		this._delegate.enableButton(state);

		/* for a working button the state was set to either 1 or 3 */
		this.temporarySetEnabledState( this._initialState, true );

		// this could do anything..
		// if( this.json.javascript )
		//	eval( this.json.javascript );

		// we dont rest in enabled state - move on to active state
		this._fsm_controller.handle( "enabledSuccessfully" );
	},

	fireButtonAction: function( nextState ) {

		var self = this;

		// ensure we can't click again until we have received response
		self.temporarySetEnabledState( 0, false );

		var afterAction = function() {
			//alert("success");
			/* Move this back into the succeess function */
			self.temporarySetEnabledState( nextState, true );
			// on complete set the button state back to normal
			self._fsm_controller.handle( "clickActionCompleted" );
			console.log("** Complete **");
		};
		var onCompleteStuffHash =  {onCompleteTarget: self, onCompleteAction: afterAction};
		this._delegate.fireAction( nextState, onCompleteStuffHash );
	},

	fireButtonAction1: function() {
		this.fireButtonAction( 1 );
	},

	temporarySetEnabledState: function( state, enabled ) {
		this._delegate.temporarySetEnabledState(state,enabled);
	}
});

/*
 * Append a couple of states to 3 state button
*/
HooFiveStateItem = HooThreeStateItem.extend({

	/* States */
	_active_state2:			undefined,
	_active_down_state2:	undefined,
	_clicked_state2:		undefined,
	_abortClick_state2:		undefined,

	/* Commands */
	_showMouseDownCmd2:		HooStateMachine_command.create( {name: "showMouseDown2"} ),
	_showMouseUpCmd2:		HooStateMachine_command.create( {name: "showMouseUp2"} ),
	_fireButtonActionCmd2:	HooStateMachine_command.create( {name: "fireButtonAction2"} ),

	/* Add some extra states and overide some */
	_setupStateMachine: function() {
		arguments.callee.base.apply(this,arguments);

		this._active_state2			= HooStateMachine_state.create( {name: "active2" });
		this._active_down_state2	= HooStateMachine_state.create( {name: "active_down2" });
		this._clicked_state2		= HooStateMachine_state.create( {name: "clicked2" });
		this._abortClick_state2		= HooStateMachine_state.create( {name: "abort-click2" });

		/* Transitions */
		this._active_state2.addTransition( this._buttonPressed_event, this._active_down_state2 );
		this._active_down_state2.addTransition( this._buttonReleased_event, this._clicked_state2 );
		this._active_down_state2.addTransition( this._mouseDraggedOut_event, this._abortClick_state2 );
		this._abortClick_state2.addTransition( this._clickAbortComplete_event, this._active_state2 );

		// these need to overide simple button ? How?
		this._clicked_state1.removeAllTransitions();
		this._clicked_state1.addTransition( this._clickComplete_event, this._active_state2 );
		this._clicked_state2.addTransition( this._clickComplete_event, this._active_state1 );

		// dont assume that when the button goes to 'enabled' this means state1
		if( this._initialState==3 ) {
			this._enabled_state.removeAllTransitions();
			this._enabled_state.addTransition( this._enabledSuccessfully_event, this._active_state2 );
		}

		this._active_state2.addEntryAction( this._showMouseUpCmd2 );
		this._active_down_state2.addEntryAction( this._showMouseDownCmd2 );
		this._clicked_state2.addEntryAction( this._fireButtonActionCmd2 );
		this._abortClick_state2.addEntryAction( this._abortClickActionCmd );
	},

	showMouseDown2: function() {
		this.showMouseDownState(4);
	},

	showMouseUp2: function() {
		this.showMouseUpState(3);
	},

	fireButtonAction2: function() {
		this.fireButtonAction(3);
	}
});


HooSliderItem = HooThreeStateItem.extend({

	// instead of aborting when drag outside..
	enableButton: function( state ) {
		arguments.callee.base.apply(this,arguments);
		var button = this._delegate.getClickableItem();
		if( button ) {
			button.unbind( 'mouseleave');
		}
	},

	showMouseDownState: function( state ) {
		var self = this;
		$(window).bind( 'mouseup', {target:this._fsm_controller, action:'handle', arg:"buttonReleased" }, this._delegate.eventTrampoline )
		$(window).bind( 'mousemove', function(e){
			self.lastWindowEvent = e;
			self._delegate.mouseDragged(e);
		})
		this._delegate.showMouseDownState(state);
	},

	showMouseUpState: function( state ) {
		$(window).unbind( 'mouseup' );
		$(window).unbind( 'mousemove' );
		this._delegate.showMouseUpState(state);
	}

});

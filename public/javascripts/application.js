function fuckYeah( stringArg1 ) {
	alert( stringArg1 );
}

/* O L D   S T U F F */

/*
 * Sob sob sob
 * I don't like this being here. This is really an integral part of textListView and is not intended to be used elsewhere
 * Oh, i don't know how to lay this stuff out
*/
function crippleListView( listID, targetFunctionName ) {

	var listSelector = listID + " > li";
	var $list = $( listSelector );
	$.each( $list, function(index, value) {

		var $each = $(value);			// alert($each.text());

		// select a in $value - obvious!
		var $anchor = $('a', $each);
		var currentLink = $anchor.attr( "href" );

		// remove the link from the anchor
		$anchor.attr( "href", "#" );

		// and add our jQuery event instead
		$anchor.mousedown( function( ) {

			// call function from string 'targetFunctionName'
			var fn = window[targetFunctionName];
			if(typeof fn === 'function') {
				fn( currentLink );
			}

		});
	});
}

/* S E T   U P */

/*
 * look for data-jsclass in the page, create an instance for each
 */
function createJSObjectsFromRubyObjects() {

	// -- get all objects with data-jsClass attribute ''
	var all_jsClass_objects = $(":customdata(jsclass)" );
	$.each( all_jsClass_objects, function( i, ob )
	{
		var idString = $(ob).attr('id');
		var className = $(ob).customdata('jsclass');
		var newInstanceName = '_'+idString;
		var jsonName = newInstanceName+'_json';
		var jsonOb =  window[jsonName];
		if( jsonOb==undefined )
			console.error("cannot find json for "+className );

		var hmm = eval(className);
		var newInstance = hmm.create( {id: idString, json: jsonOb} );

		if( window[newInstanceName]!=undefined )
			console.error("Cannot create instance of "+className );

		window[newInstanceName] = newInstance;
		console.log( "Created "+newInstanceName );
	});
}


/* S T A T E   M A C H I N E */

HooStateMachine_testCommandChannel = SC.Object.extend({

	send: function( command ) {
		alert( command.name );
	}
});

HooStateMachine_abstractEvent = SC.Object.extend({
	name: undefined,
});

HooStateMachine_command = HooStateMachine_abstractEvent.extend({
});

HooStateMachine_event = HooStateMachine_abstractEvent.extend({
});

HooStateMachine_state = SC.Object.extend({

	name: undefined,
	actions: undefined,
	transitions: undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
		this.actions = new Array();
		this.transitions = new Object();
	},

	addTransition: function( event, targetState ) {
		if( targetState==null || event==null )
			alert("Error: invalid params for HooStateMachine_state");
		var t = HooStateMachine_transition.create( {source:this, trigger:event, target:targetState} );
		this.transitions[event.name] = t;
	},

	addAction: function( cmd ) {
		this.actions.push(cmd);
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

	executeActions: function( commandsChannel ) {

		$.each( this.actions, function(index, value) {
			commandsChannel.send( value );
		});
	},

});

HooStateMachine_transition = SC.Object.extend({

	source: undefined,
	trigger: undefined,
	target: undefined,

	getEventName: function() {
		return this.trigger.name;
	},
});


HooStateMachine = SC.Object.extend({

	startState: undefined,
	resetEvents: undefined,

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

	handle: function( eventName ) {

		if( this.currentState.hasTransition(eventName) )
			this.transitionTo( this.currentState.targetState(eventName) );

		else if( this.machine.isResetEvent(eventName) )
			this.transitionTo( this.machine.startState );

		// ignore unknown events
		else {
			// console.log("unknown event "+eventName );
		}
	},

	// private
	transitionTo: function( targetState ) {
		 this.currentState = targetState;
		 targetState.executeActions( this.commandsChannel );
	 },
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
	idle_state.addAction( unlockDoorCmd );
	idle_state.addAction( lockPanelCmd );

	active_state.addTransition( drawerOpened_event, waitingForLight_state );
	active_state.addTransition( lightOn_event, waitingForDrawer_state );

	waitingForLight_state.addTransition( lightOn_event, unlockedPanel_state );

	waitingForDrawer_state.addTransition( drawerOpened_event, unlockedPanel_state );

	unlockedPanel_state.addAction( unlockPanelCmd );
	unlockedPanel_state.addAction( lockDoorCmd );
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


/* W I D G E T S */

/*
 * This is the prototype class for an instance that should be automatically created on
 * page load because it was tagged with a jsclass attribute server side.
 * set these values in Create( hash )
*/
HooWidget = SC.Object.extend({
	json: "undefined",
	id: "undefined",
});


/* C R A P */

/*
 * MyClassA
*/
MyClassA = SC.Object.extend({

	foo: "foo1",

	init: function() {
		arguments.callee.base.apply(this,arguments);
		console.log("inited!");
	},

	bar: function() {
		return "bar";
	},

	myMethod: function() {
		console.log('myMethod1');
	}
});

MyClassA.prototype.foo = "foo1"


/*
 * MyClassB
*/
MyClassB = MyClassA.extend({

	myMethod: function() {
		arguments.callee.base.apply(this,arguments);
		console.log("myMethod2");
	}
});


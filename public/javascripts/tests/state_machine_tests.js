module( "State Machine", {
  setup: function() {
    ok( true, "once extra assert per test" );
  }
});

ABoo.HooStateMachine_testCommandChannel = SC.Object.extend({
	send: function( command ) {
		//alert( command.name );
	}
});

// Lets kick off state machine tests
test("state machine fundamentals", function() {

	var anEvent	= ABoo.HooStateMachine_event.create( {_name: "doorClosed"} );
	var aComand = ABoo.HooStateMachine_command.create( {_name: "unlockPanel"} );
	var aState = ABoo.HooStateMachine_state.create( {_name: "idle" });

	equals( anEvent._name, "doorClosed", "!" );
	equals( aComand._name, "unlockPanel", "!" );
	equals( aState._name, "idle", "!" );
});

test("add transition", function() {

	var idle_state = ABoo.HooStateMachine_state.create( {_name: "idle" });
	var active_state = ABoo.HooStateMachine_state.create( {_name: "active" });
	var doorClosed_event = ABoo.HooStateMachine_event.create( {_name: "doorClosed"} );
	idle_state.addTransition( doorClosed_event, active_state );

	equals( idle_state.hasTransition("doorClosed"), true, "!" );
});

test("the simplest state machine example", function() {

	// She has a secret compartment in her bedroom that is normally locked and concealed.
	// To open it, she has to close the door, then open the second drawer in her chest and turn her bedside light on—in either order.
	// Once these are done, the secret panel is unlocked for her to open.
	// The controller Communicates with devices by receiving event messages and sending command messages.
	// These are both four-letter codes sent through the communication channels.
	var doorClosed_event		= ABoo.HooStateMachine_event.create( {_name: "doorClosed"} );
	var drawerOpened_event		= ABoo.HooStateMachine_event.create( {_name: "drawerOpened"} );
	var lightOn_event			= ABoo.HooStateMachine_event.create( {_name: "lightOn"} );
	var doorOpened_event		= ABoo.HooStateMachine_event.create( {_name: "doorOpened"} );
	var panelClosed_event		= ABoo.HooStateMachine_event.create( {_name: "panelClosed"} );

	var unlockPanelCmd 			= ABoo.HooStateMachine_command.create( {_name: "unlockPanel"} );
	var lockPanelCmd 			= ABoo.HooStateMachine_command.create( {_name: "lockPanel"} );
	var lockDoorCmd 			= ABoo.HooStateMachine_command.create( {_name: "lockDoor"} );
	var unlockDoorCmd 			= ABoo.HooStateMachine_command.create( {_name: "unlockDoor"} );

	var idle_state				= ABoo.HooStateMachine_state.create( {_name: "idle" });
	var active_state			= ABoo.HooStateMachine_state.create( {_name: "active" });
	var waitingForLight_state	= ABoo.HooStateMachine_state.create( {_name: "waitingForLight" });
	var waitingForDrawer_state	= ABoo.HooStateMachine_state.create( {_name: "waitingForDrawer" });
	var unlockedPanel_state		= ABoo.HooStateMachine_state.create( {_name: "unlockedPanel" });

	var stateMachineInstance = ABoo.HooStateMachine.create( {_startState: idle_state} );

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

	var testReciever = ABoo.HooStateMachine_testCommandChannel.create();
	var controller = ABoo.HooStateMachine_controller.create( { _currentState: idle_state, _machine: stateMachineInstance, _commandsChannel: testReciever } );

	equals( controller._currentState._name, "idle", "!" );

	controller.handle( "doorClosed" );
	equals( controller._currentState._name, "active", "!" );

	controller.handle( "drawerOpened" );
	equals( controller._currentState._name, "waitingForLight", "!" );

	controller.handle( "lightOn" );
	equals( controller._currentState._name, "unlockedPanel", "!" );
});


test("the simplest state machine example with json", function() {

	var simplestSM_config = {
		"states": [
			"st_idle",
			"st_active",
			"st_waitingForLight",
			"st_waitingForDrawer",
			"st_unlockedPanel"
		],
		"events": [
			"ev_doorClosed",
			"ev_drawerOpened",
			"ev_lightOn",
			"ev_doorOpened",
			"ev_panelClosed"
		],
		"commands": [
			"cmd_unlockPanel",
			"cmd_lockPanel",
			"cmd_lockDoor",
			"cmd_unlockDoor"
		],
		"transitions": [
			{ "state": "st_idle",					"event": "ev_doorClosed", 	"nextState": "st_active" },
			{ "state": "st_active", 				"event": "ev_drawerOpened",	"nextState": "st_waitingForLight" },
			{ "state": "st_active", 				"event": "ev_lightOn", 		"nextState": "st_waitingForDrawer" },
			{ "state": "st_waitingForLight",		"event": "ev_lightOn", 		"nextState": "st_unlockedPanel" },
			{ "state": "st_waitingForDrawer", 		"event": "ev_drawerOpened", "nextState": "st_unlockedPanel" },
			{ "state": "st_unlockedPanel", 			"event": "ev_panelClosed", 	"nextState": "st_idle" }
		],
		"actions": [
			{"state": "st_idle", 			"entryAction": "cmd_unlockDoor", 	"exitAction": null },
			{"state": "st_idle", 			"entryAction": "cmd_lockPanel", 	"exitAction": null },
			{"state": "st_unlockedPanel", 	"entryAction": "cmd_unlockPanel", 	"exitAction": null },
			{"state": "st_unlockedPanel", 	"entryAction": "cmd_lockDoor",		"exitAction": null }
		],
		"resetEvents": [
			"ev_doorOpened"
		]
	};

	var simpleStateMachineParser = ABoo.HooStateMachineConfigurator.create({_config: simplestSM_config });
	var stateMachineInstance = ABoo.HooStateMachine.create( {_startState: simpleStateMachineParser.state("st_idle") } );
	var testReciever = ABoo.HooStateMachine_testCommandChannel.create();
	var controller = ABoo.HooStateMachine_controller.create( { _currentState: simpleStateMachineParser.state("st_idle"), _machine: stateMachineInstance, _commandsChannel: testReciever } );

	equals( controller._currentState._name, "st_idle", "!" );

	controller.handle( "ev_doorClosed" );
	equals( controller._currentState._name, "st_active", "!" );

	controller.handle( "ev_drawerOpened" );
	equals( controller._currentState._name, "st_waitingForLight", "!" );

	controller.handle( "ev_lightOn" );
	equals( controller._currentState._name, "st_unlockedPanel", "!" );
});

test("a hierarchical state machine example", function() {

	var hierarchicalSM_config = {
		"states": [
			"st_off",
			"st_on",
			["st_loading", "st_on"],
			["st_playing", "st_on"]
		],
		"events": [
			"ev_load",
			"ev_play",
			"ev_turnOff"
		],
		"commands": [
			"cmd_showOff",
			"cmd_showOn",
			"cmd_showLoad",
			"cmd_showPlay"
		],
		"transitions": [
			{ "state": "st_off",		"event": "ev_load", 	"nextState": "st_loading" },
			{ "state": "st_off", 		"event": "ev_play",		"nextState": "st_playing" },
			{ "state": "st_loading", 	"event": "ev_play",		"nextState": "st_playing" }
		],
		"actions": [
			{"state": "st_off", 		"entryAction": "cmd_showOff", 	"exitAction": null },
			{"state": "st_on", 			"entryAction": "cmd_showOn", 	"exitAction": null },
			{"state": "st_loading", 	"entryAction": "cmd_showLoad", 	"exitAction": null },
			{"state": "st_playing", 	"entryAction": "cmd_showPlay",	"exitAction": null }
		],
		"resetEvents": ["ev_turnOff"]
	};

	var resultCommands = new Array();
	var TestCommandChannel = SC.Object.extend({
		send: function( command ) {
			resultCommands.push( command.name );
		}
	});

	var cmdChl = TestCommandChannel.create();
	var hierarchicalStateMachineParser = ABoo.HooStateMachineConfigurator.create({ _config: hierarchicalSM_config });
	var stateMachineInstance = ABoo.HooStateMachine.create( { _startState: hierarchicalStateMachineParser.state("st_off"), _resetEvents: hierarchicalStateMachineParser._resetEvents } );
	var controller = ABoo.HooStateMachine_controller.create( { _currentState: hierarchicalStateMachineParser.state("st_off"), _machine: stateMachineInstance, _commandsChannel: cmdChl } );

	equals( controller._currentState._name, "st_off", "!" );
	controller.handle( "ev_load" );
	equals( controller._currentState._name, "st_loading", "!" );
	controller.handle( "ev_play" );
	equals( controller._currentState._name, "st_playing", "!" );
	controller.handle( "ev_turnOff" );
	equals( controller._currentState._name, "st_off", "!" );

	// -- test result commands

});


test("ThreeStateButtonStateMachine", function() {

	var ninja = new Mock();

	var threeButtonSM = ABoo.ThreeStateButtonStateMachine.create({ _controller: ninja });
	equals( threeButtonSM.currentStateName(), "st_disabled", "!" );

	ninja.expects(1).method('cmd_enableButton');
	ninja.expects(1).method('cmd_showMouseUp1');
	threeButtonSM.processInputSignal( "ev_showState1" );
	equals( threeButtonSM.currentStateName(), "st_active1", "!" );
	ok(ninja.verify(), "!");

	ninja.expects(1).method('cmd_showMouseDown1');
	threeButtonSM.processInputSignal( "ev_buttonPressed" );
	equals( threeButtonSM.currentStateName(), "st_active_down1", "!" );
	ok(ninja.verify(), "!");

	ninja.expects(1).method('cmd_showMouseDownOut1');
	threeButtonSM.processInputSignal( "ev_mouseDraggedOutside" );
	equals( threeButtonSM.currentStateName(), "st_active_down_out1", "!" );
	ok(ninja.verify(), "!");

	var ninja = new Mock();
	ninja.expects(1).method('cmd_showMouseDown1');
	threeButtonSM._controller = ninja;
	threeButtonSM.processInputSignal( "ev_mouseDraggedInside" );
	equals( threeButtonSM.currentStateName(), "st_active_down1", "!" );
	ok(ninja.verify(), "!");

	ninja.expects(1).method('cmd_fireButtonAction1');
	threeButtonSM.processInputSignal( "ev_buttonReleased" );
	equals( threeButtonSM.currentStateName(), "st_clicked1", "!" );
	ok(ninja.verify(), "!");

	ninja.expects(1).method('cmd_disableButton');
	threeButtonSM.processInputSignal( "ev_disable" );
	equals( threeButtonSM.currentStateName(), "st_disabled", "!" );
	ok(ninja.verify(), "!");

	//threeButtonSM.processInputSignal( "ev_error" );
	//equals( threeButtonSM.currentStateName(), "st_off", "!" );

	//threeButtonSM.processInputSignal( "ev_clickAbortCompleted" );
	//equals( threeButtonSM.currentStateName(), "st_off", "!" );
});

test("FiveStateButtonStateMachine", function() {

	var ninja = new Mock();

	var fiveButtonSM = ABoo.FiveStateButtonStateMachine.create({ _controller: ninja });
});



	// ok( true, "this test is fine" );
	// var value = "hello";
	// equals( "hello", value, "We expect value to be hello" );


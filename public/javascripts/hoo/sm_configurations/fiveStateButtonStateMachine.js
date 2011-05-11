
FiveStateButtonStateMachine = AbstractConfiguration.extend({

init: function( /* _controller */ ) {
	arguments.callee.base.apply( this, arguments );
},

sm_config: function() {

	var fiveStateButtonStateMachine_config = {
		"states": [
			"st_disabled",
			"st_enabled",

			// ["st_error", 	"st_disabled"],
			["state1",				"st_enabled"],
			["state2",				"st_enabled"],

			/* The high-level states you use */
			["st_active1", 			"state1"],
			["st_active_down1", 	"state1"],
			["st_active_down_out1", "state1"],
			["st_clicked1", 		"state1"],
			["st_abort-click1", 	"state1"],

			["st_active2",	 		"state2"],
			["st_active_down2", 	"state2"],
			["st_active_down_out2", "state2"],
			["st_clicked2", 		"state2"],
			["st_abort-click2", 	"state2"]
		],
		"events": [
			"ev_disable",
			"ev_error",

			"ev_showState1",
			"ev_showState2",
			"ev_buttonPressed",
			"ev_buttonReleased",
			"ev_mouseDraggedOutside",
			"ev_mouseDraggedInside",

			"ev_clickAbortCompleted"
		],
		// Doh! you can add many commands to 1 state
		"commands": [
			"cmd_enableButton",
			"cmd_showMouseUp1",
			"cmd_showMouseDown1",
			"cmd_showMouseDownOut1",
			"cmd_fireButtonAction1",

			"cmd_showMouseDown2",
			"cmd_showMouseDownOut2",
			"cmd_showMouseUp2",
			"cmd_fireButtonAction2",

			"cmd_abortClickAction",
			"cmd_disableButton"
			//"cmd_showError"
		],

		"transitions": [
			{"state": "st_disabled", 		"event": "ev_showState1",			"nextState": "st_active1"},
			{"state": "st_disabled", 		"event": "ev_showState2",			"nextState": "st_active2"},

			{"state": "st_enabled", 		"event": "ev_showState1",			"nextState": "st_active1"},
			{"state": "st_enabled", 		"event": "ev_showState2",			"nextState": "st_active2"},

			// state 1
			{"state": "st_active1", 		"event": "ev_buttonPressed",		"nextState": "st_active_down1"},
			{"state": "st_active_down1", 	"event": "ev_buttonReleased",		"nextState": "st_clicked1"},
			{"state": "st_active_down1", 	"event": "ev_mouseDraggedOutside",	"nextState": "st_active_down_out1"},
			{"state": "st_active_down_out1","event": "ev_mouseDraggedInside",	"nextState": "st_active_down1"},
			{"state": "st_active_down_out1","event": "ev_buttonReleased",		"nextState": "st_abort-click1"},

			{"state": "st_abort-click1", 	"event": "ev_clickAbortCompleted",	"nextState": "st_active1"},

			// state 2
			{"state": "st_active2", 		"event": "ev_buttonPressed",		"nextState": "st_active_down2"},
			{"state": "st_active_down2", 	"event": "ev_buttonReleased",		"nextState": "st_clicked2"},
			{"state": "st_active_down2", 	"event": "ev_mouseDraggedOutside",	"nextState": "st_active_down_out2"},
			{"state": "st_active_down_out2","event": "ev_mouseDraggedInside",	"nextState": "st_active_down2"},
			{"state": "st_active_down_out2","event": "ev_buttonReleased",		"nextState": "st_abort-click2"},

			{"state": "st_abort-click2", 	"event": "ev_clickAbortCompleted",	"nextState": "st_active2"}

			// Toggle between active states
			// {"state": "st_clicked1", 		"event": "ev_clickActionCompleted",	"nextState": "st_active2"},
			// {"state": "st_clicked2", 		"event": "ev_clickActionCompleted",	"nextState": "st_active1"},

			// all the reset events - not sure on which states errors can occur, all?
			//{"state": "st_enabled", 		"event": "ev_disable",				"nextState": "st_disabled"},
			//{"state": "st_enabled", 		"event": "ev_error",				"nextState": "st_error"}
		],

		"actions": [
			{"state": "st_enabled", 		"entryAction": "cmd_enableButton", 		"exitAction": null },
			{"state": "st_disabled",		"entryAction": "cmd_disableButton",		"exitAction": null },
			//{"state": "st_error",			"entryAction": "cmd_showError",			"exitAction": null },

			{"state": "st_active1", 		"entryAction": "cmd_showMouseUp1", 		"exitAction": null },
			{"state": "st_active_down1", 	"entryAction": "cmd_showMouseDown1", 	"exitAction": null },
			{"state": "st_active_down_out1","entryAction": "cmd_showMouseDownOut1",	"exitAction": null },
			{"state": "st_clicked1", 		"entryAction": "cmd_fireButtonAction1",	"exitAction": null },
			{"state": "st_abort-click1",	"entryAction": "cmd_abortClickAction",	"exitAction": null },

			{"state": "st_active2",			"entryAction": "cmd_showMouseUp2",		"exitAction": null },
			{"state": "st_active_down2",	"entryAction": "cmd_showMouseDown2",	"exitAction": null },
			{"state": "st_active_down_out2","entryAction": "cmd_showMouseDownOut2",	"exitAction": null },
			{"state": "st_clicked2",		"entryAction": "cmd_fireButtonAction2",	"exitAction": null },
			{"state": "st_abort-click2",	"entryAction": "cmd_abortClickAction",	"exitAction": null },
		],
		"resetEvents":[
			"ev_disable", "ev_error"
		]
	};
	return fiveStateButtonStateMachine_config;
}

});



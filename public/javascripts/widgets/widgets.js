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

/* Abstract Button */
HooAbstractButton = HooWidget.extend({

	// forward events to 'this'
	eventTrampoline: function(e) {
		var target = e.data.target;
		var action = e.data.action;
		var arg = e.data.arg;
		target[action](arg, e);
	},

	/* JQuery helpers */
	getButton: function() {
		var buttonQuery = "#"+this.id+" button:first";
		var $button = $( buttonQuery );
		if( $button.length!=1 )
			console.error("Could not find the Button");
		return $button;
	},

	getForm: function() {
		var formQuery = "#"+this.id+" form:first";
		var $form = $( formQuery );
		if( $form.length!=1 )
			console.error("Could not find the form");
		return $form;
	},

	setButtonText: function( arg ) {
		var $butt = this.getButton();
		var $contents = $butt.find("span");
		$contents.text( arg );
	},

	positionBackground:function( state ) {
		var $butt = this.getButton();
		var height = this.getButton().height();
		var offset = state * height;

		if ( typeof this.positionBackground.previousHeight!='undefined' ) {
		//	if( typeof console.assert!=undefined )
		//		console.assert( height==this.positionBackground.previousHeight, "shit" );
		}
		this.positionBackground.previousHeight = height;
		$butt.css( "backgroundPosition", "0px -"+offset+"px" );
	},
});


/*
 * After spending considerable time on this i have come to the conclusion that you
 * SHOULD NOT be able to dragout of the button, then back over and have it recieve
 * your mouse-up event. Although this seems desirable, it doesn't work if you mouse-up
 * outside of the window.
 * There are 2 options.. capture events for when the mouse rolls out of the window OR
 * just return the button to normal state when you rollout
 *
 */

/* Simple Button */
HooSimpleButton = HooAbstractButton.extend({

	_fsm_controller: undefined,

	/* States */
	_active_state1:				undefined,
	_active_down_state1:		undefined,

	// the clicked state is needed bacuse we dont want to return the button to normal
	// on mouse up we want to hold it in clicked state until the action is complete
	_clicked_state1:			undefined,
	_abortClick_state1:			undefined,

	/* Events - so these are like, Class variables? */
	_buttonPressed_event:		HooStateMachine_event.create( {name: "buttonPressed"} ),
	_buttonReleased_event:		HooStateMachine_event.create( {name: "buttonReleased"} ),
	_mouseDraggedOut_event:		HooStateMachine_event.create( {name: "mouseDraggedOutside"} ),
	_clickComplete_event:		HooStateMachine_event.create( {name: "clickActionCompleted"} ),
	_clickAbortComplete_event:	HooStateMachine_event.create( {name: "clickAbortCompleted"} ),

	/* Commands */
	_showMouseUpCmd1:			HooStateMachine_command.create( {name: "showMouseUp1"} ),
	_showMouseDownCmd1: 		HooStateMachine_command.create( {name: "showMouseDown1"} ),
	_fireButtonActionCmd1:		HooStateMachine_command.create( {name: "fireButtonAction1"} ),
	_abortClickActionCmd:		HooStateMachine_command.create( {name: "abortClickAction"} ),


	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);

		if(this.json.state>0) {

			/* States */
			this._active_state1			= HooStateMachine_state.create( {name: "active1" });
			this._active_down_state1	= HooStateMachine_state.create( {name: "active_down1" });
			this._clicked_state1		= HooStateMachine_state.create( {name: "clicked1" });
			this._abortClick_state1		= HooStateMachine_state.create( {name: "abort-click1" });

			/* Transitions */
			this._active_state1.addTransition( this._buttonPressed_event, this._active_down_state1 );
			this._active_down_state1.addTransition( this._buttonReleased_event, this._clicked_state1 );

			// These are for the version where you can drag outside of the button - its rubbish
			// _active_down_out_state	= HooStateMachine_state.create( {name: "active_down_out" }),
			// _mouseDraggedWithin_event= HooStateMachine_event.create( {name: "mouseDraggedWithin"} ),
			// _mouseLeftWindow_event	= HooStateMachine_event.create( {name: "mouseLeftWindow"} ),
			// active_down_state.addTransition( mouseDraggedOut_event, active_down_out_state ),
			// active_down_out_state.addTransition( buttonReleased_event, abortClick_state ),
			// active_down_out_state.addTransition( mouseDraggedWithin_event, active_down_state ),
			// active_down_out_state.addTransition( mouseLeftWindow_event, abortClick_state ),

			// This is for the alternate version where dragging outside the button resets it
			this._active_down_state1.addTransition( this._mouseDraggedOut_event, this._abortClick_state1 );

			this._clicked_state1.addTransition( this._clickComplete_event, this._active_state1 );

			/* This needs overiding in button 2 - how to handle ? */
			this._abortClick_state1.addTransition( this._clickAbortComplete_event, this._active_state1 );

			this._active_state1.addAction( this._showMouseUpCmd1 ),
			this._active_down_state1.addAction( this._showMouseDownCmd1 ),
			this._clicked_state1.addAction( this._fireButtonActionCmd1 ),
			this._abortClick_state1.addAction( this._abortClickActionCmd ),

			/* set up our button statemachine */
			var stateMachineInstance = HooStateMachine.create( {startState: this._active_state1} );
			this._fsm_controller = HooStateMachine_controller.create( { currentState: this._active_state1, machine: stateMachineInstance, commandsChannel: this } );

			this.setupBindings();
		}
	},

	setupBindings: function() {

		this.getButton().bind( 'mousedown', {target:this._fsm_controller, action:'handle', arg:"buttonPressed" }, this.eventTrampoline );
		this.getButton().bind( 'mouseleave', {target:this._fsm_controller, action:'handle', arg:"mouseDraggedOutside" }, this.eventTrampoline );

		this.getButton().removeAttr("disabled");
		this.getButton().css( "pointer-events", "auto" ); // control whether can be the target of mouse events

		var mouseDownText = this.json.labelStates[this.json.state];
		this.setButtonText( mouseDownText );

		// this.getForm().submit( {ob: this}, this.onClick ); // Bind submit - manually doing this
	},

	/* Incoming commands from the state machine */
	send: function( command ) {
		this[command.name](); // interpet the command as an instance method and call it
	},

	showMouseDownState: function( state ) {
		$('body').bind( 'mouseup', {target:this._fsm_controller, action:'handle', arg:"buttonReleased" }, this.eventTrampoline );

		var mouseDownText = this.json.labelStates[state];
		this.setButtonText( mouseDownText );

		this.positionBackground(state);
	},

	showMouseUpState: function( state ) {
		$('body').unbind( 'mouseup' );

		var mouseDownText = this.json.labelStates[state];
		this.setButtonText( mouseDownText );

		this.positionBackground(state);
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

	fireButtonAction: function( nextState ) {

		// ensure we can't click again until we have received response
		this.temporarySetEnabledState( 0, false );
		var self = this;
		var form = this.getForm();
		form.submit(function(e) {
			// alert('Handler for .submit() called.');

			// this === form at this point
			var hmm = $(this).serialize();
			alert(this.action);
			$.ajax({ url: this.action, type:'POST', data: hmm,
				success: function(data) {
					//alert("success");
					/* Move this back into the succeess function */
					self.temporarySetEnabledState( nextState, true );
					// on complete set the button state back to normal
					self._fsm_controller.handle( "clickActionCompleted" );
					form.unbind('submit');
					console.log("** Complete **");
				}
			});

			// The next two lines are equivalent
			e.preventDefault();
			return false;
		});
		form.submit();
	},

	fireButtonAction1: function() {
		this.fireButtonAction( 1 );
	},

	temporarySetEnabledState: function( state, enabled ) {

		var mouseDownText = "";

		if(enabled){
			this.getButton().removeAttr("disabled");
			this.getButton().css( "pointer-events", "auto" );
		} else {
			this.getButton().attr('disabled', 'disabled');
			this.getButton().css( "pointer-events", "none" );
		}
		// this.getForm().unbind( "submit", this.onClick );
		// this.getButton().unbind( "mousedown", this.mouseDown );

		var mouseDownText = this.json.labelStates[state];
		this.setButtonText( mouseDownText );
		this.positionBackground( state );
	},
});





/*
 * Extends the simpleButton 2 add another state, eg followed, unfollowed
 *
 */
/* Toggle Button */
HooToggleButton = HooSimpleButton.extend({

	/* States */
	_active_state2:			undefined,
	_active_down_state2:	undefined,
	_clicked_state2:		undefined,
	_abortClick_state2:		undefined,

	/* Commands */
	_showMouseDownCmd2:		HooStateMachine_command.create( {name: "showMouseDown2"} ),
	_showMouseUpCmd2:		HooStateMachine_command.create( {name: "showMouseUp2"} ),
	_fireButtonActionCmd2:	HooStateMachine_command.create( {name: "fireButtonAction2"} ),


	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);

		if(this.json.state>0) {

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

			this._active_state2.addAction( this._showMouseUpCmd2 );
			this._active_down_state2.addAction( this._showMouseDownCmd2 );
			this._clicked_state2.addAction( this._fireButtonActionCmd2 );
			this._abortClick_state2.addAction( this._abortClickActionCmd );

		}
	},

	showMouseDown2: function() {
		this.showMouseDownState(4);
	},

	showMouseUp2: function() {
		this.showMouseUpState(3);
	},

	fireButtonAction2: function() {
		this.fireButtonAction(3);
	},
});


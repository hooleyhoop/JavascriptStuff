/* Abstract Button */
HooAbstractButton = HooWidget.extend({

	itemType: "button",
	textHolder: "span",

	// forward events to 'this'
	eventTrampoline: function(e) {
		var target = e.data.target;
		var action = e.data.action;
		var arg = e.data.arg;
		target[action](arg, e);
	},

	/* JQuery helpers */
	getClickableItem: function() {
		var buttonQuery = "#"+this.id+" "+this.itemType+":first";
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

	// works for buttons and spans if textHolder is set correctly
	setContentText:  function( arg ) {
		var $butt = this.getClickableItem();
		var $contents = $butt.find( this.textHolder );
		$contents.text( arg );
	},

	positionBackground:function( state ) {
		var $butt = this.getClickableItem();
		var height = $butt.height();
		var offset = state * height;

		if ( typeof this.positionBackground.previousHeight!='undefined' ) {
		//	if( typeof console.assert!==undefined )
		//		console.assert( height==this.positionBackground.previousHeight, "shit" );
		}
		this.positionBackground.previousHeight = height;
		$butt.css( "backgroundPosition", "0px -"+offset+"px" );
	}
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

/* Simple Form Button */
HooFormButtonSimple = HooAbstractButton.extend({

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

	_mouseClickAction:			undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);

		// if state is 0 button is completely disabled
		if(this.json.state>0) {

			var self = this;

			this._setupStateMachine();

			// Setup bindings as configured in the json
			var shouldStartActive = true;
			if( this.json.bindings )
			{
				if( this.json.bindings.enabledBinding ) {
					var b = this.json.bindings.enabledBinding;
					// begin disabled, wait for a short while, then inspect the targets state.
					// If the target is already 'ready' - no need to bind!
					shouldStartActive = false;
					setTimeout( function(){
						// TODO! This kind of stuff needs sharing between classes
						var target = window[b.enabled_taget];
						if(target===undefined)
							debugger;
						var initialState = target.get( b.enabled_property );
						if(initialState) {
							self._fsm_controller.handle( "enable" );
						} else {
							target.addObserver( b.enabled_property, self, self.readyDidChange );
						}
					}, 10);
				}
			}

			// set up actions as configured in the json
			if( this.json.javascriptActions )
			{
				if( this.json.javascriptActions.mouseClick )
				{
					setTimeout( function(){
						var target	= window[ self.json.javascriptActions.mouseClick.action_taget ];
						var action	= target[ self.json.javascriptActions.mouseClick.action_event ];
						var arg		= self.json.javascriptActions.mouseClick.action_arg;
						self._mouseClickAction = { t:target, a:action, w:arg };
					}, 10);
				}
			}

			// initial state depends on whether _enabled? has been bound or not.. if it is bound, then follow that property, if it isnt bound start in the on state
			this.setInitialState( shouldStartActive );
		}
	},

	/* Overide this is more complex buttons */
	_setupStateMachine: function() {

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

		this._enabled_state.addAction( this._enableButtonCmd );
		this._active_state1.addAction( this._showMouseUpCmd1 );
		this._active_down_state1.addAction( this._showMouseDownCmd1 );
		this._clicked_state1.addAction( this._fireButtonActionCmd1 );
		this._abortClick_state1.addAction( this._abortClickActionCmd );

		/* set up our button statemachine */
		var stateMachineInstance = HooStateMachine.create( {startState: this._disabled_state} );
		this._fsm_controller = HooStateMachine_controller.create( { currentState: this._disabled_state, machine: stateMachineInstance, commandsChannel: this } );
	},

	// we observed a change!
	readyDidChange: function( target, property ) {
		target.removeObserver( property, this, this.readyDidChange );

		if(target.get(property))
			this._fsm_controller.handle( "enable" );
	},

	setInitialState: function( shouldStartActive ) {
		// regardless, begin in the disabled state
		this.temporarySetEnabledState( 0, false );
		// if enabled? is not observing anything, assume we should advance to the enabled state automatically
		if(shouldStartActive)
			this._fsm_controller.handle( "enable" );
	},

	setBackgroundAndTextState: function( state ) {

		var mouseDownText = this.json.labelStates[state];
		this.setContentText( mouseDownText );
		this.positionBackground(state);
	},

	/* Incoming commands from the state machine */
	send: function( command ) {
		this[command.name](); // interpet the command as an instance method and call it
	},

	/* This should only be called once, when it enters the enabled state */
	enableButton: function( state ) {

		var button = this.getClickableItem();
		button.bind( 'mousedown', {target:this._fsm_controller, action:'handle', arg:"buttonPressed" }, this.eventTrampoline );
		button.bind( 'mouseleave', {target:this._fsm_controller, action:'handle', arg:"mouseDraggedOutside" }, this.eventTrampoline );

		/* for a working button the state was set to either 1 or 3 */
		this.temporarySetEnabledState( this.json.state, true );

		// this could do anything..
		// if( this.json.javascript )
		//	eval( this.json.javascript );

		// we dont rest in enabled state - move on to active state
		this._fsm_controller.handle( "enabledSuccessfully" );
	},

	showMouseDownState: function( state ) {
		$('body').bind( 'mouseup', {target:this._fsm_controller, action:'handle', arg:"buttonReleased" }, this.eventTrampoline );

		this.setBackgroundAndTextState( state );
	},

	showMouseUpState: function( state ) {
		$('body').unbind( 'mouseup' );

		this.setBackgroundAndTextState( state );
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

		var self = this;

		var beforeAction = function() {
			// ensure we can't click again until we have received response
			self.temporarySetEnabledState( 0, false );
		};

		var afterAction = function() {
			//alert("success");
			/* Move this back into the succeess function */
			self.temporarySetEnabledState( nextState, true );
			// on complete set the button state back to normal
			self._fsm_controller.handle( "clickActionCompleted" );
			console.log("** Complete **");
		};

		/* Ignore the form action altogether and do a javascript action - cant be async at the mo */
		var jsOveridingFormAction = function( argsHash ) {

			self._mouseClickAction.a.call( self._mouseClickAction.t, self._mouseClickAction.w );

			// -if we are in a form - stop the form doing it's thing
			self.getForm().submit(function(e) { return false; });
			self.getForm().submit();
			argsHash.onComplete();
		};

		/* Submit the forms regular action using jquery */
		var formSubmitAction = function( argsHash ) {

			var form = self.getForm();
			form.submit(function(e) {
				// alert('Handler for .submit() called.');

				// this === form at this point
				var hmm = $(this).serialize();
				alert(this.action);
				$.ajax({ url: this.action, type:'POST', data: hmm,
					success: function(data) {
						form.unbind('submit');

						// of course, you remebered to pass in the callback..
						argsHash.onComplete();
					}
				});

				// The next two lines are equivalent
				e.preventDefault();
				return false;
			});
			form.submit();
		};


		// Ok, lets do it!
		beforeAction();

		if( this._mouseClickAction!==undefined )
			jsOveridingFormAction( {onComplete: afterAction } );
		else
			formSubmitAction( {onComplete: afterAction } );
	},

	fireButtonAction1: function() {
		this.fireButtonAction( 1 );
	},

	// this has somewhere to go..
	temporarySetEnabledState: function( state, enabled ) {

		var mouseDownText = "";
		var button = this.getClickableItem();

		if(enabled){
			button.removeAttr("disabled");
			button.css( "pointer-events", "auto" );
		} else {
			button.attr('disabled', 'disabled');
			button.css( "pointer-events", "none" );
		}
		// this.getForm().unbind( "submit", this.onClick );
		// button.unbind( "mousedown", this.mouseDown );

		this.setBackgroundAndTextState( state );
	}

});





/*
 * Extends the simpleButton 2 add another state, eg followed, unfollowed
 *
 */
/* Toggle Form Button */
HooFormButtonToggle = HooFormButtonSimple.extend({

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
		if( this.json.state==3 ) {
			this._enabled_state.removeAllTransitions();
			this._enabled_state.addTransition( this._enabledSuccessfully_event, this._active_state2 );
		}

		this._active_state2.addAction( this._showMouseUpCmd2 );
		this._active_down_state2.addAction( this._showMouseDownCmd2 );
		this._clicked_state2.addAction( this._fireButtonActionCmd2 );
		this._abortClick_state2.addAction( this._abortClickActionCmd );
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

/* Simple link button */

HooDivButtonSimple = HooFormButtonSimple.extend({

	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */
	itemType: "div",
	textHolder: "a",

	// maybe make this async
	fireButtonAction: function( nextState ) {
		this.temporarySetEnabledState( 0, false );

		// we might want to make this async
		if( this._mouseClickAction!==undefined )
		{
			this._mouseClickAction.a.call( this._mouseClickAction.t, this._mouseClickAction.w );
		} else {
			console.info("HooDivButtonSimple - button hasnt been given a javascript action");
			window.location = this.getClickableItem().find( this.textHolder ).attr("href");
		}
		this.temporarySetEnabledState( nextState, true );
		this._fsm_controller.handle( "clickActionCompleted" );
	}
});

/* two state link button */

HooDivButtonToggle = HooFormButtonToggle.extend({

	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */
	itemType: "div",
	textHolder: "a",

	// maybe make this async
	fireButtonAction: function( nextState ) {
		this.temporarySetEnabledState( 0, false );
		if(this._jsAction)
			this._jsAction();
		else {
			console.info("HooDivButtonToggle -button hasnt been given a javascript action");
			window.location = this.getClickableItem().find( this.textHolder ).attr("href");
		}
		this.temporarySetEnabledState( nextState, true );
		this._fsm_controller.handle( "clickActionCompleted" );
	}
});


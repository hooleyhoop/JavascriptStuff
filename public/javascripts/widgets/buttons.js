HooThreeStateItem = SC.Object.extend({

	_threeButtonSM: undefined,
	_graphic: undefined,
	_clickableItem$: undefined,
//hmi suppose we need this	_target: undefined,
//hmi suppose we need this	_action: undefined,

	init: function( /* _graphic, _clickableItem$ */ ) {
		arguments.callee.base.apply( this, arguments );
		this._threeButtonSM = ThreeStateButtonStateMachine.create({ _controller: this });
		this._graphic.showDisabledButton();
		this._listenerDebugger = ActiveListenerDebugger.create();
	},

	// input
	// - ev_showState1, ev_disable, ev_error
	sendEvent: function( ev ) {
		this._threeButtonSM.processInputSignal( ev );
	},

	setButtonTarget: function( target, action ) {
		this._target = target; this._action = action;
	},

	// State machine callbacks
	cmd_enableButton: function() {

		this._listenerDebugger.addListener( this._clickableItem$, 'mousedown', this, this._mouseDown );
	},

	cmd_disableButton: function() {

		this._listenerDebugger.removeListener( this._clickableItem$, 'mousedown', this, this._mouseDown );
		this._graphic.showDisabledButton();
	},

	cmd_showMouseUp1: function() {
		this._graphic.showMouseUp1State();
	},

	cmd_showMouseDown1: function() {
		this._graphic.showMouseDown1State();
	},

	cmd_showMouseDownOut1: function() {
		this._graphic.showMouseUp1State();
 	},

	cmd_fireButtonAction1: function() {
//hmi suppose we need this		var success = this._action.call( this._target );
	},

	cmd_abortClickAction: function() {
		this.sendEvent( "ev_clickAbortCompleted" );
	},

	_mouseDown: function( e ) {

		this._listenerDebugger.addListener( $(window), 'mouseup', this, this._mouseStageUp );
		this._listenerDebugger.addListener( this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler );
		this._listenerDebugger.addListener( this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler );

		this.sendEvent( "ev_buttonPressed" );
	},

	_mouseStageUp: function(e) {

		this._listenerDebugger.removeListener( $(window), 'mouseup', this, this._mouseStageUp );
		this._listenerDebugger.removeListener( this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler );
		this._listenerDebugger.removeListener( this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler );

		this.sendEvent("ev_buttonReleased");
	},

	_mouseRollOutHandler: function(e) {
		this.sendEvent("ev_mouseDraggedOutside");
	},

	_mouseRollOverHandler: function(e) {
		this.sendEvent("ev_mouseDraggedInside");
	},

	currentStateName: function() {
		return this._threeButtonSM.currentStateName();
	},

	setCurrentStateName: function( arg ) {
		return this._threeButtonSM.processInputSignal( arg );
	}

	/* This should only be called once, when it enters the enabled state */
//eh?	enableButton: function( state ) {


//eh?		this._delegate.enableButton(state);

		/* for a working button the state was set to either 1 or 3 */
//eh?		this.temporarySetEnabledState( this._initialState, true );

		// this could do anything..
		// if( this.json.javascript )
		//	eval( this.json.javascript );

		// we dont rest in enabled state - move on to active state
//eh?		this._fsm_controller.handle( "enabledSuccessfully" );
//eh?	},

//eh?	fireButtonAction: function( nextState ) {

//eh?		var self = this;

		// ensure we can't click again until we have received response
//eh?		self.temporarySetEnabledState( 0, false );

//eh?		var afterAction = function() {
			//alert("success");
			/* Move this back into the succeess function */
//eh?			self.temporarySetEnabledState( nextState, true );
			// on complete set the button state back to normal
//eh?			self._fsm_controller.handle( "clickActionCompleted" );
//eh?			console.log("** Complete **");
//eh?		};
//eh?		var onCompleteStuffHash =  {onCompleteTarget: self, onCompleteAction: afterAction};
//eh?		this._delegate.fireAction( nextState, onCompleteStuffHash );
//eh?	},

//eh?	fireButtonAction1: function() {
//eh?		this.fireButtonAction( 1 );
//eh?	},

//eh?	temporarySetEnabledState: function( state, enabled ) {
//eh?		this._delegate.temporarySetEnabledState(state,enabled);
//eh?	}
});


/* Abstract Button */
// HooAbstractButton.mixin = HooWidget.extend({

HooAbstractButton = HooWidget.extend({

	textHolder: "span",

	/* JQuery helpers */
	getForm: function() {
		var formQuery = "#"+this.id+" form:first";
		var $form = $( formQuery );
		if( $form.length!=1 )
			console.error("Could not find the form");
		return $form;
	},

	getOuterWidth: function() {
		var $butt = this.getClickableItem();
		return $butt.outerWidth();
	},

	setOuterWidth: function( arg ) {
		var $butt = this.getClickableItem();
		$butt.width(arg);
	},

	getTextContent: function() {
		var $butt = this.getClickableItem();
		var $contents = $butt.find( this.textHolder );
		return $contents.text();
	}
});


HooThreeStateButtonGraphic = SC.Object.extend({

	_labelStates: undefined,
	_itemType: undefined,
	_rootItemId: undefined,

	getClickableItem: function() {
		var buttonQuery = "#"+this._rootItemId+" "+this._itemType+":first";
		var $button = $( buttonQuery );
		if( $button.length!=1 )
			console.error("Could not find the Button");
		return $button;
	},

	showDisabledButton: function() {
		this.setBackgroundAndTextState( 0 );
	},
	showMouseUp1State: function() {
		this.setBackgroundAndTextState( 1 );
	},
	showMouseDown1State: function() {
		this.setBackgroundAndTextState( 2 );
	},

	setBackgroundAndTextState: function( state ) {

		var mouseDownText = this._labelStates[state];
		this.setContentText( mouseDownText );
		this.positionBackground(state);
	},

	// works for buttons and spans if textHolder is set correctly
	setContentText:  function( arg ) {
		var $butt = this.getClickableItem();
		var $contents = $butt.find( this.textHolder );
		$contents.text( arg );
	},

	positionBackground:function( state ) {
		var $butt = this.getClickableItem();
		var height = $butt.outerHeight();
		var offset = state * height;
		if ( typeof this.positionBackground.previousHeight!='undefined' ) {
		//	if( typeof console.assert!==undefined )
		//		console.assert( height==this.positionBackground.previousHeight, "shit" );
		}
		this.positionBackground.previousHeight = height;
		// console.log("moving background "+offset);

		$butt.css( "backgroundPosition", "0px -"+offset+"px" );
	}
});


/* Simple Form Button */
HooFormButtonSimple = HooWidget.extend({

//hmm	_stateMachine:				undefined,
//hmm	_mouseClickAction:			undefined,
	_threeButtonSM: undefined,
	_threeStateButtonGraphic: undefined,

	init: function( /* {id: idString, json: jsonOb} - init never has args */ ) {
		arguments.callee.base.apply( this, arguments );

		if(this._threeStateButtonGraphic==undefined)
			this._createGraphic();

		if(this._threeButtonSM==undefined)
			this._threeButtonSM = HooThreeStateItem.create( { _graphic:this._threeStateButtonGraphic, _clickableItem$: this._threeStateButtonGraphic.getClickableItem() } );

//presumably i need this		this._threeButtonSM.setButtonTarget( this, this._mouseDown );

//hmm		if( this.json.initialState>0 ) {
//hmm			var self = this;
//hmm			this.createStatemachine();
//hmm			this._stateMachine._delegate = this;
//hmm			this._stateMachine._setupStateMachine( this.json.initialState );

			// initial state depends on whether _enabled? has been bound or not.. if it is bound, then follow that property, if it isnt bound start in the on state
//hmm			this._stateMachine.setInitialState( 0 );
//hmm		}
	},

	_createGraphic: function() {
		this._threeStateButtonGraphic = HooThreeStateButtonGraphic.create( { _rootItemId:this.id, _itemType:"button", _labelStates: this.json.labelStates } );
	},

//hmm	createStatemachine: function() {
//hmm		this._stateMachine = HooThreeStateItem.create();
//hmm	},

	setupDidComplete: function() {

//hmm		var self = this;

		// Setup bindings as configured in the json

		// if there is no binding and the initial state isn't disabled, we need to call 'enable', right?

		/* at the moment this only handles initial turn-on! you cannot observe a turn off */
		var hasBinding = this.setup_hoo_binding_from_json( 'enabledBinding' );
		if( hasBinding==false && this.json.initialState>0 ) {
			this._threeButtonSM.sendEvent( "ev_showState1" );
		}
		// set up actions as configured in the json - mixin?
//hmm		this._mouseClickAction = this.setup_hoo_action( 'mouseClickAction' );
	},

	// we observed a change in our enabled binding
	enabledDidChange: function( target, property ) {

		var observedVal = target[property];
		// alert(observedVal);
		if( observedVal==null || observedVal==undefined || observedVal==0 || observedVal==false )
			this._threeButtonSM.setCurrentStateName( "ev_disable" );
		else {
			this._threeButtonSM.setCurrentStateName( "ev_showState1" );
		}
	},

	currentStateName: function() {
		return this._threeButtonSM.currentStateName();
	}


//hmm	showMouseDownState: function( state ) {
//hmm		arguments.callee.base.apply(this,arguments);
//hmm	},

//hmm	showMouseUpState: function( state ) {
//hmm		arguments.callee.base.apply(this,arguments);
//hmm	},

//hmm	fireAction: function( nextState, argsHash ) {

//hmm		var self = this;

//hmm		if( this._mouseClickAction!==undefined ){

		/* Ignore the form action altogether and do a javascript action - cant be async at the mo */
//hmm			self._mouseClickAction.a.call( self._mouseClickAction.t, self._mouseClickAction.w );

			// -if we are in a form - stop the form doing it's thing
//hmm			self.getForm().submit(function(e) { return false; });
//hmm			self.getForm().submit();
//hmm			argsHash.onComplete();

//hmm		} else {
			/* Submit the forms regular action using jquery */
//hmm			var form = self.getForm();
//hmm			form.submit(function(e) {
				// alert('Handler for .submit() called.');

				// this === form at this point
//hmm				var hmm = $(this).serialize();

//hmm				$.ajax({ url: this.action, type:'POST', data: hmm,
//hmm					success: function(data) {
//hmm						form.unbind('submit');

						// of course, you remebered to pass in the callback..
//hmm						argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
//hmm					}
//hmm				});

				// The next two lines are equivalent
//hmm				e.preventDefault();
//hmm				return false;
//hmm			});
//hmm			form.submit();
//hmm		}

//hmm	},

	/* This should only be called once, when it enters the enabled state */
//hmm	enableButton: function( state ) {
//hmm	},

	// this has somewhere to go..
//hmm	temporarySetEnabledState: function( state, enabled ) {

//hmm		var mouseDownText = "";
//hmm		var button = this.getClickableItem();

//hmm		if(enabled){
//hmm			button.removeAttr("disabled");
//hmm			button.css( "pointer-events", "auto" );
//hmm		} else {
//hmm			button.attr('disabled', 'disabled');
//hmm			button.css( "pointer-events", "none" );
//hmm		}
		// this.getForm().unbind( "submit", this.onClick );
		// button.unbind( "mousedown", this.mouseDown );

//hmm		this.setBackgroundAndTextState( state );
//hmm	}
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
			button.unbind( 'mouseleave' );
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





/*
 * Extends the simpleButton 2 add another state, eg followed, unfollowed
 *
 */
/* Toggle Form Button */
HooFormButtonToggle = HooFormButtonSimple.extend({

	// we just use a different state machine than the three state button, everthing else is the same
	createStatemachine: function() {
		this._stateMachine = HooFiveStateItem.create();
	}
});

/* 'Orrible Multiple Inheritance stuff */
DivButtonMixin = {
	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */

//putback	textHolder: "a",

	_createGraphic: function() {
		this._threeStateButtonGraphic = HooThreeStateButtonGraphic.create( { _rootItemId:this.id, _itemType:"div", _labelStates: this.json.labelStates } );
	},

	// maybe make this async
	fireAction: function( nextState, argsHash ) {

		// we might want to make this async
//putback		if( this._mouseClickAction!==undefined )
//putback		{
			// Doesnt work on ie
//putback			this._mouseClickAction.a.apply( this._mouseClickAction.t, [this._mouseClickAction.w] );
//putback		} else {
//putback			console.info("HooDivButtonSimple - button hasnt been given a javascript action");
//putback			window.location = this.getClickableItem().find( this.textHolder ).attr("href");
//putback		}
		// of course, you remebered to pass in the callback..
//putback		argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
	}
};

/* Simple link button */
HooDivButtonSimple = HooFormButtonSimple.extend( DivButtonMixin, {
});

/* two state link button */
HooDivButtonToggle = HooFormButtonToggle.extend( DivButtonMixin, {
});

DynamicWidthButtonMixin = {

	initMixin: function( /* init never has args */ ) {
		var maxWidth = this._calculateGreatestWidth();
		this.setOuterWidth(maxWidth);
	},

	// swap in each text label and measure
	_calculateGreatestWidth: function() {
		var self = this;
		var maxWidth = 0;
		var label = this.getTextContent();
		$(this.json.labelStates).each(function(index,element) {
			self.setContentText(element);
			var widthForText = self.getOuterWidth();
			maxWidth = widthForText > maxWidth ? widthForText : maxWidth;
		});
		self.setContentText(label);
		return maxWidth;
	}
}

HooDivButtonSimpleDynamicWidth = HooDivButtonSimple.extend( DynamicWidthButtonMixin, {});

HooDivButtonToggleDynamicWidth = HooDivButtonToggle.extend( DynamicWidthButtonMixin, {});

GUI_Views_Drawing_Menus_Items_HooTextLinkItem = HooDivButtonSimpleDynamicWidth.extend({});
GUI_Views_Drawing_Menus_Items_HooTextToggleItem = HooDivButtonToggleDynamicWidth.extend({});

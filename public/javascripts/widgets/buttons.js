/* Abstract Button */
// HooAbstractButton.mixin = HooWidget.extend({

HooAbstractButton = HooWidget.extend({

	itemType: "button",
	textHolder: "span",

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

	_stateMachine:				undefined,
	_mouseClickAction:			undefined,

	init: function( /* init never has args */ ) {
		arguments.callee.base.apply( this, arguments );

		if( this.json.initailState>0 ) {

			var self = this;

			this.createStatemachine();
			this._stateMachine._delegate = this;
			this._stateMachine._setupStateMachine( this.json.initailState );

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
							self._stateMachine._fsm_controller.handle( "enable" );
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
			this._stateMachine.setInitialState( shouldStartActive );
		}
	},

	createStatemachine: function() {
		this._stateMachine = HooThreeStateItem.create();
	},

	// we observed a change!
	readyDidChange: function( target, property ) {
		target.removeObserver( property, this, this.readyDidChange );

		if(target.get(property))
			this._stateMachine._fsm_controller.handle( "enable" );
	},

	setBackgroundAndTextState: function( state ) {

		var mouseDownText = this.json.labelStates[state];
		this.setContentText( mouseDownText );
		this.positionBackground(state);
	},

	showMouseDownState: function( state ) {
		arguments.callee.base.apply(this,arguments);
		this.setBackgroundAndTextState( state );
	},

	showMouseUpState: function( state ) {
		arguments.callee.base.apply(this,arguments);
		this.setBackgroundAndTextState( state );
	},

	fireAction: function( nextState, argsHash ) {

		var self = this;

		if( this._mouseClickAction!==undefined ){

		/* Ignore the form action altogether and do a javascript action - cant be async at the mo */
			self._mouseClickAction.a.call( self._mouseClickAction.t, self._mouseClickAction.w );

			// -if we are in a form - stop the form doing it's thing
			self.getForm().submit(function(e) { return false; });
			self.getForm().submit();
			argsHash.onComplete();

		} else {
			/* Submit the forms regular action using jquery */
			var form = self.getForm();
			form.submit(function(e) {
				// alert('Handler for .submit() called.');

				// this === form at this point
				var hmm = $(this).serialize();
				// alert(this.action);
				$.ajax({ url: this.action, type:'POST', data: hmm,
					success: function(data) {
						form.unbind('submit');

						// of course, you remebered to pass in the callback..
						argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
					}
				});

				// The next two lines are equivalent
				e.preventDefault();
				return false;
			});
			form.submit();
		}

	},

	/* This should only be called once, when it enters the enabled state */
	enableButton: function( state ) {
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

	// we just use a different state machine than the three state button, everthing else is the same
	createStatemachine: function() {
		this._stateMachine = HooFiveStateItem.create();
	}
});


/* Simple link button */

HooDivButtonSimple = HooFormButtonSimple.extend({

	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */
	itemType: "div",
	textHolder: "a",

	// maybe make this async
	fireAction: function( nextState, argsHash ) {

		// we might want to make this async
		if( this._mouseClickAction!==undefined )
		{
			this._mouseClickAction.a.call( this._mouseClickAction.t, this._mouseClickAction.w );
		} else {
			console.info("HooDivButtonSimple - button hasnt been given a javascript action");
			window.location = this.getClickableItem().find( this.textHolder ).attr("href");
		}
		// of course, you remebered to pass in the callback..
		argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
	}
});

/* two state link button */

HooDivButtonToggle = HooFormButtonToggle.extend({

	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */
	itemType: "div",
	textHolder: "a",

	// maybe make this async
	fireAction: function( nextState, argsHash ) {

		if(this._jsAction)
			this._jsAction();
		else {
			console.info("HooDivButtonToggle -button hasnt been given a javascript action");
			window.location = this.getClickableItem().find( this.textHolder ).attr("href");
		}
		// of course, you remebered to pass in the callback..
		argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
	}
});


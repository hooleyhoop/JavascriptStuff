HooThreeStateItem = SC.Object.extend({

	_buttonSM: undefined,
	_graphic: undefined,
	_clickableItem$: undefined,
	_target:undefined,
	_action: undefined,
	_actionArg: undefined,
	_isAsync: undefined,

	init: function( /* _graphic */ ) {
		arguments.callee.base.apply( this, arguments );

		this._createSM();
		this._graphic.showDisabledButton();
		this._listenerDebugger = ActiveListenerDebugger.create();
	},

	_createSM: function() {
		this._buttonSM = ThreeStateButtonStateMachine.create({ _controller: this });
	},

	setButtonTarget: function( target, action, arg, isAsync ) {

		arg = typeof(arg) != 'undefined' ? arg : null;
		isAsync = typeof(isAsync) != 'undefined' ? isAsync : false;

		this._target = target;
		this._action = action;
		this._actionArg = arg;
		this._isAsync = isAsync;
	},

	// input
	// - ev_showState1, ev_disable, ev_error
	sendEvent: function( ev ) {
		this._buttonSM.processInputSignal( ev );
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
		this._fire("ev_showState1" );
	},

	_fire: function( nextState ) {

		var self = this;

		//TODO:
		// how do we handle toggle button?
		// how do we handle async actions?
		// how do we go back to the correct state?

		var completionCallback = function() {
			self.sendEvent( nextState );
		}
		var onCompleteStuffHash =  {onCompleteTarget: self, onCompleteAction: completionCallback};

		if(this._target) {
			//this._delegate.fireAction();
			this._action.call( this._target, this._actionArg, onCompleteStuffHash );
		}
		if(this._isAsync==false){
			completionCallback();
		}
	},

	cmd_abortClickAction: function() {
		this.sendEvent( "ev_clickAbortCompleted" );
	},

	_mouseDown: function( e ) {

		// cant get $(window).mouseup to work on IE7 so using document instead
		this._listenerDebugger.addListener( $(document), 'mouseup', this, this._mouseStageUp );
		this._clickableItem$.unselectable = "on";
		this._clickableItem$.onselectstart = function(){return false};

		this._listenerDebugger.addListener( this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler );
		this._listenerDebugger.addListener( this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler );

		this.sendEvent( "ev_buttonPressed" );
		e.preventDefault();
	},

	_mouseStageUp: function( e ) {

		this._listenerDebugger.removeListener( $(window), 'mouseup', this, this._mouseStageUp );
		this._listenerDebugger.removeListener( this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler );
		this._listenerDebugger.removeListener( this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler );

		this.sendEvent("ev_buttonReleased");
		e.preventDefault();
	},

	_mouseRollOutHandler: function(e) {
		this.sendEvent("ev_mouseDraggedOutside");
	},

	_mouseRollOverHandler: function(e) {
		this.sendEvent("ev_mouseDraggedInside");
	},

	currentStateName: function() {
		return this._buttonSM.currentStateName();
	},

	setCurrentStateName: function( arg ) {
		return this._buttonSM.processInputSignal( arg );
	}
});

/*
 * Append a couple of states to 3 state button
*/
HooFiveStateItem = HooThreeStateItem.extend({

	/* Add some extra states and overide some */
	_createSM: function() {
		this._buttonSM = FiveStateButtonStateMachine.create({ _controller: this });
	},

	cmd_showMouseDown2: function() {
		this._graphic.showMouseDown2State();
	},

	cmd_showMouseUp2: function() {
		this._graphic.showMouseUp2State();
	},

	cmd_showMouseDownOut2: function() {
		this._graphic.showMouseDown2State();
 	},

	cmd_fireButtonAction1: function() {
		this._fire("ev_showState2" );
	},

	cmd_fireButtonAction2: function() {
		this._fire("ev_showState1" );
	}
});

/* Abstract Button */

HooAbstractButtonGraphic = SC.Object.extend({

	_rootItemId: undefined,
	_itemType: undefined,


	getClickableItem: function() {
		var itemQuery = "#"+this._rootItemId+" "+this._itemType+":first";
		var $item = $( itemQuery );
		if( $item.length!=1 )
			console.error("Could not find the clickable item");
		return $item;
	}
})

// When we need some different kinds of graphics start chopping up this heirarchy
HooButtonGraphic = HooAbstractButtonGraphic.extend({

	_textHolder: undefined,
	_labelStates: undefined,

	getForm: function() {
		var formQuery = "#" + this._rootItemId + " form:first";
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
		var $contents = $butt.find( this._textHolder );
		return $contents.text();
	},

	getHref: function() {
		var href = this.getClickableItem().find( this._textHolder ).attr("href");
		HOO_nameSpace.assert( href, "cant find href" );
		return href;
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
	showMouseUp2State: function() {
		this.setBackgroundAndTextState( 3 );
	},
	showMouseDown2State: function() {
		this.setBackgroundAndTextState( 4 );
	},

	setBackgroundAndTextState: function( state ) {

		var mouseDownText = this._labelStates[state];
		this.setContentText( mouseDownText );
		this.positionBackground(state);
	},

	// works for buttons and spans if _textHolder is set correctly
	setContentText:  function( arg ) {
		var $butt = this.getClickableItem();
		var $contents = $butt.find( this._textHolder );
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

HrefLoader = SC.Object.extend({
	_href: undefined,
	submit: function( arg, completionHash ) {
		window.location = this._href;
	}
});

FormSubmiter = SC.Object.extend({
	_form: undefined,

	init: function( /* {id: idString, json: jsonOb} - init never has args */ ) {
		arguments.callee.base.apply( this, arguments );
	},

	submit: function( arg, completionHash ) {

		var form = this._form;
		form.submit( function(e) {
			// alert('Handler for .submit() called.');

			// this === form at this point
			var hmm = $(this).serialize();
			var act = form.attr('action')
			HOO_nameSpace.assert(act, "cant find href");

			$.ajax({ url: act, type:'POST', data: hmm,
				success: function(data) {
					form.unbind('submit');

					console.log("c o m p l e t e");
					// of course, you remebered to pass in the callback..
					completionHash.onCompleteAction.call( completionHash.onCompleteTarget );
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log("bugger, that didnt quite work out: "+textStatus+" "+errorThrown);
					completionHash.onCompleteAction.call( completionHash.onCompleteTarget );
				}
			});

			// The next two lines are equivalent
			e.preventDefault();
			return false;
		});
		form.submit();
	}
});


/* Simple Form Button */
HooFormButtonSimple = HooWidget.extend({

	_mouseClickAction: undefined,
	_buttonSMControl: undefined,
	_buttonGraphic: undefined,

	init: function( /* {id: idString, json: jsonOb} - init never has args */ ) {
		arguments.callee.base.apply( this, arguments );

		if(this._buttonGraphic==undefined) {
			this._createGraphic();
		}

		if(this._buttonSMControl==undefined) {
			this._createStateController();
		}
	},

	_createGraphic: function() {

		this._buttonGraphic = HooButtonGraphic.create( { _rootItemId:this.id, _itemType:"button", _textHolder:"span", _labelStates: this.json.labelStates } );
	},

	_createStateController: function() {

		this._buttonSMControl = HooThreeStateItem.create( { _graphic:this._buttonGraphic } );
	},

	setupDidComplete: function() {

		// Setup bindings as configured in the json
		// if there is no binding and the initial state isn't disabled, we need to call 'enable', right?

		var clickable = this._buttonGraphic.getClickableItem();
		if(!clickable)
			debugger;

		this._buttonSMControl._clickableItem$ = clickable;

		/* at the moment this only handles initial turn-on! you cannot observe a turn off */
		var hasBinding = this.setup_hoo_binding_from_json( 'enabledBinding' );
		if( hasBinding==false && this.json.initialState>0 ) {
			if(this.json.initialState==1)
				this._buttonSMControl.sendEvent( "ev_showState1" );
			else if(this.json.initialState==3)
				this._buttonSMControl.sendEvent( "ev_showState2" );
			else
				debugger;
		}
		// set up actions as configured in the json - mixin?
		this._mouseClickAction = this.setup_hoo_action_from_json( 'mouseClickAction' );
		if( this._mouseClickAction==null ) {
			console.info("No JSON Action - using form");
			this._mouseClickAction = this.defaultAction();
		}
		this._buttonSMControl.setButtonTarget( this._mouseClickAction.t, this._mouseClickAction.a, this._mouseClickAction.w, this._mouseClickAction.actionIsAsync );
	},

	// Maaan, this shouldn't really be here, but when i get the other buttons working again sort out the heirarchy
	defaultAction: function() {

		if(this._buttonGraphic.getForm) {
			var form = this._buttonGraphic.getForm();
			var target	= FormSubmiter.create( {_form: form} );
			var action	= target.submit;
			var arg = null;
			return { t:target, a:action, w:arg, actionIsAsync:true };
		}
		return null;
	},

	// we observed a change in our enabled binding
	enabledDidChange: function( target, property ) {

		var observedVal = target[property];
		// alert(observedVal);
		if( observedVal==null || observedVal==undefined || observedVal==0 || observedVal==false )
			this._buttonSMControl.setCurrentStateName( "ev_disable" );
		else {
			this._buttonSMControl.setCurrentStateName( "ev_showState1" );
		}
	},

	currentStateName: function() {
		return this._buttonSMControl.currentStateName();
	}
});


/*
 * Extends the simpleButton 2 add another state, eg followed, unfollowed
 *
 */
/* Toggle Form Button */
HooFormButtonToggle = HooFormButtonSimple.extend({

	// we just use a different state machine than the three state button, everthing else is the same
	_createStateController: function() {

		this._buttonSMControl = HooFiveStateItem.create( { 	_graphic:this._buttonGraphic } );
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
		$(window).bind( 'mouseup', {target:this._fsm_controller, action:'handle', arg:"buttonReleased" }, eventTrampoline )
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



/* 'Orrible Multiple Inheritance stuff */
DivButtonMixin = {
	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */

	_createGraphic: function() {
		this._buttonGraphic = HooButtonGraphic.create( { _rootItemId:this.id, _itemType:"div", _textHolder:"a", _labelStates: this.json.labelStates } );
	},

	defaultAction: function() {
		if( this._buttonGraphic.getHref ) {
			var href = this._buttonGraphic.getHref();
			var target	= HrefLoader.create( {_href: href} );
			var action	= target.submit;
			var arg = null;
			return { t:target, a:action, w:arg, actionIsAsync:true };
		}
		return null;
	}
};

/* Simple link button */
HooDivButtonSimple = HooFormButtonSimple.extend( DivButtonMixin, {
});

/* two state link button */
HooDivButtonToggle = HooFormButtonToggle.extend( DivButtonMixin, {
});

DynamicWidthButtonMixin = {

	// TODO: more of a graphic thing?
	initMixin: function( /* init never has args */ ) {
		var maxWidth = this._calculateGreatestWidth();
		this._buttonGraphic.setOuterWidth(maxWidth);
	},

	// TODO: this should wbe in graphic?
	// swap in each text label and measure
	_calculateGreatestWidth: function() {
		var self = this;
		var maxWidth = 0;
		var label = this._buttonGraphic.getTextContent();
		$(this.json.labelStates).each(function(index,element) {
			self._buttonGraphic.setContentText(element);
			var widthForText = self._buttonGraphic.getOuterWidth();
			maxWidth = widthForText > maxWidth ? widthForText : maxWidth;
		});
		self._buttonGraphic.setContentText(label);
		return maxWidth;
	}
}

HooDivButtonSimpleDynamicWidth = HooDivButtonSimple.extend( DynamicWidthButtonMixin, {});

HooDivButtonToggleDynamicWidth = HooDivButtonToggle.extend( DynamicWidthButtonMixin, {});

GUI_Views_Drawing_Menus_Items_HooTextLinkItem = HooDivButtonSimpleDynamicWidth.extend({});
GUI_Views_Drawing_Menus_Items_HooTextToggleItem = HooDivButtonToggleDynamicWidth.extend({});

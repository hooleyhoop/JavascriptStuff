
/* Abstract Button */

ABoo.HooAbstractButtonGraphic = SC.Object.extend({

	_rootItemId: undefined,
	_itemType: undefined,

	getClickableItem: function() {

		var itemQuery = "#"+this._rootItemId+" "+this._itemType+":first";
		var $item = $( itemQuery );
		if( $item.length!=1 )
			console.warn("Could not find the clickable item");
		return $item;
	}
});

// When we need some different kinds of graphics start chopping up this heirarchy
ABoo.HooButtonGraphic = ABoo.HooAbstractButtonGraphic.extend({

	_textHolder: undefined,
	_labelStates: undefined,

	getForm: function() {
		var formQuery = "#" + this._rootItemId + " form:first";
		var $form = $( formQuery );
		if( $form.length!=1 )
			console.warn("Could not find the form");
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

ABoo.HrefLoader = SC.Object.extend({
	_href: undefined,
	submit: function( arg, completionHash ) {
		window.location = this._href;
	}
});

ABoo.FormSubmiter = SC.Object.extend({
	_form: undefined,

	//init: function( /* {id: idString, json: jsonOb} - init never has args */ ) {
	//    this._super();
	//},

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
ABoo.HooFormButtonSimple = ABoo.HooWidget.extend({

	_mouseClickAction: undefined,
	_buttonSMControl: undefined,
	_buttonGraphic: undefined,

	init: function( /* {id: idString, json: jsonOb} - init never has args */ ) {
	    this._super();

		if(this._buttonGraphic==undefined) {
			this._createGraphic();
		}

		if(this._buttonSMControl==undefined) {
			this._createStateController();
		}
	},

	_createGraphic: function() {

		this._buttonGraphic = ABoo.HooButtonGraphic.create( { _rootItemId:this.id, _itemType:"button", _textHolder:"span", _labelStates: this.json.labelStates } );
	},

	_createStateController: function() {

		this._buttonSMControl = ABoo.HooThreeStateItem.create( { _graphic:this._buttonGraphic } );
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
			var target	= ABoo.FormSubmiter.create( {_form: form} );
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
ABoo.HooFormButtonToggle = ABoo.HooFormButtonSimple.extend({

	// we just use a different state machine than the three state button, everthing else is the same
	_createStateController: function() {

		this._buttonSMControl = ABoo.HooFiveStateItem.create( { _graphic:this._buttonGraphic } );
	}
});

//ABoo.HooFormButtonToggleAsync = ABoo.HooFormButtonSimple.extend({

	// we just use a different state machine than the three state button, everthing else is the same
//	_createStateController: function() {

//		this._buttonSMControl = ABoo.HooFiveStateItem.create( { _graphic:this._buttonGraphic, _autoShowNextState:false } );
//	}
//});

ABoo.HooSliderItem = ABoo.HooThreeStateItem.extend({

	// instead of aborting when drag outside..
	enableButton: function( state ) {
	    this._super();
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
ABoo.DivButtonMixin = {
	/* Mostly this differs from the form button - has a div instead of button and anchor instead of span */

	_createGraphic: function() {
		this._buttonGraphic = ABoo.HooButtonGraphic.create( { _rootItemId:this.id, _itemType:"div", _textHolder:"a", _labelStates: this.json.labelStates } );
	},

	defaultAction: function() {
		if( this._buttonGraphic.getHref ) {
			var href = this._buttonGraphic.getHref();
			var target	= ABoo.HrefLoader.create( {_href: href} );
			var action	= target.submit;
			var arg = null;
			return { t:target, a:action, w:arg, actionIsAsync:true };
		}
		return null;
	}
};

/* Simple link button */
ABoo.HooDivButtonSimple = ABoo.HooFormButtonSimple.extend( ABoo.DivButtonMixin, {
});

/* two state link button */
ABoo.HooDivButtonToggle = ABoo.HooFormButtonToggle.extend( ABoo.DivButtonMixin, {
});

 ABoo.DynamicWidthButtonMixin = {

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

ABoo.HooDivButtonSimpleDynamicWidth = ABoo.HooDivButtonSimple.extend( ABoo.DynamicWidthButtonMixin, {});

ABoo.HooDivButtonToggleDynamicWidth = ABoo.HooDivButtonToggle.extend( ABoo.DynamicWidthButtonMixin, {});

GUI_Views_Drawing_Menus_Items_HooTextLinkItem = ABoo.HooDivButtonSimpleDynamicWidth.extend({});
GUI_Views_Drawing_Menus_Items_HooTextToggleItem = ABoo.HooDivButtonToggleDynamicWidth.extend({});



/*
 *
*/
ABoo.HooBarberPoleGraphic = SC.Object.extend( ABoo.HooCanvasViewMixin, ABoo.PropertyAnimMixin, {

	_barberPoleSprite: undefined,
	_isBusy: false,
	_lastUpdateTime:undefined,
	_percent:0,

	// fade experiment
	_fadeAlpha: 0,
	//_fadeHelper: undefined,

	init: function( /* init never has args */ ) {
		this._super();
		this._barberPoleSprite = ABoo.BarberPoleSprite.create();
		this.addObserver('_fadeAlpha', this, this.alphaDidChange );
	},

	// canvas -> HooCanvasViewMixin
	drawContents: function( ctx, width, height ) {
		this._barberPoleSprite.spriteDraw( ctx, 0, 0, width, height, this._percent, this._fadeAlpha );
	},

	toggleBusy: function() {
		//console.log("Togglwing busy");
		this._isBusy = !this._isBusy;
		if(this._isBusy) {

			this.animateProperty( '_fadeAlpha', 1, 1000/25*8 );

			this._lastUpdateTime = -1;
			ABoo.ShiteDisplayLink.sharedDisplayLink.registerListener(this);

		} else {
			//console.log("fade off");

			this.animateProperty( '_fadeAlpha', 0, 1000/25*3 );

			ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener(this);
		}
	},

	// hmm, manually update busy spinner..?
	alphaDidChange: function (sender, key) {
		//console.log("alpha changed "+this._fadeAlpha );
		this._parentCanvas.setNeedsDisplay();
	},

	// hmm, manually update busy spinner..?
	timeUpdate: function( time ) {
		//console.log("oh yeah, im getting them upates");
		if(this._lastUpdateTime!=-1) {
			var dist = time-this._lastUpdateTime;
			this._percent = (this._percent + dist/1000)%1;
			//console.log( "this._percent is "+this._percent );
			this._parentCanvas.setNeedsDisplay();
		}
		this._lastUpdateTime = time;
	}

});

/*
 *
*/
ABoo.HooBarberPole = ABoo.HooWidget.extend({

	_hooCanvas: undefined,
	_barberPoleGraphic:undefined,

	init: function( /* init never has args */ ) {
		this._super();
		this._barberPoleGraphic = ABoo.HooBarberPoleGraphic.create();
	},

	setupDidComplete: function() {
		HOO_nameSpace.assert( this._hooCanvas, "this HooBarberPole must be added to a canvas to work" );
		this._hooCanvas.addSubview( this._barberPoleGraphic );
	},

	toggleBusy: function() {
		// console.log("Toggle Toggle");
		this._barberPoleGraphic.toggleBusy();
	},

	setSize: function ( width, height ) {
				// resize canvas
			//mwah this._$canvas.attr({ width:newWidth, height:newHeight }); // setting the size resets the canvas
			//mwah var ctx = this._$canvas[0].getContext('2d');
		this._hooCanvas._setSize( width, height );
	}
});


/*
 * yes this looks less thaN USEFUL to me too
*/
ABoo.HooSimpleSliderGraphic = ABoo.HooButtonGraphic.extend({

	showDisabledButton: function() {
		//alert("one");
	},
	showMouseUp1State: function() {
		//alert("two");
	},
	showMouseDown1State: function() {
		//alert("threes");
	}
});

/*
 *
*/
ABoo.HooSimpleSlider = ABoo.HooFormButtonSimple.extend(  ABoo.PropertyAnimMixin, {

	_loadProgressDiv:	undefined,
	_playProgressDiv:	undefined,
	_started:			false,
	_timeStep:			undefined,
	_currentTime:		undefined,
	_loadedAmount:		0,
	_playedAmount:		0,
	_maxAmount:			0,
	_maxBarWidth:		0,
	_currentWidth:		0,
	_currentWHeight:	0,

	_barberPole:		undefined,

	init: function( /* init never has args */ ) {
		this._super();
		this._loadProgressDiv = this.getFirstDomItemOfType(".loadProgress");
		this._playProgressDiv = this.getFirstDomItemOfType(".playProgress");
	},

	_createGraphic: function() {
		return ABoo.HooSimpleSliderGraphic.create( { _rootItemId:this.id, _itemType:".slider" } ); // _textHolder:"span", _labelStates: this.json.labelStates
	},

	_createStateController: function() {
		return ABoo.HooSliderItem.create( { _graphic:this._buttonGraphic } );
	},

	setupDidComplete: function() {

		this._super();
		//mwah HOO_nameSpace.assert( this._hooCanvas, "this button must be added to a canvas to work" );

		var canvas$ = this.getFirstDomItemOfType("canvas");
		var hooCanvas = ABoo.HooCanvas.create( { _$canvas:canvas$ } );
		//hooCanvas.swapInFor( this._placeHolder$ );
		//hooCanvas._setSize(200,200);

		this._barberPole = ABoo.HooBarberPole.create( {_hooCanvas: hooCanvas } );
		this._barberPole.setupDidComplete();

		// some disaster of order of operations here - resizeAll has alreadyw been called too many times, we just werent ready
		this._started = true;
		this.resizeAll();

		//mwah /* Redo Bindings */
		//mwah var hasBinding = this.setup_hoo_binding_from_json( 'enabledBinding' );
		//mwah if( hasBinding==false && this.json.initialState>0 ) {
		//mwah 	this._stateMachine.processInputSignal( "enable" );
		//mwah }

		var hasMaxValBinding = this.setup_hoo_binding_from_json( 'maxAmountValueBinding' );
		var hasLoadedValBinding = this.setup_hoo_binding_from_json( 'loadedValueBinding' );
		var hasPlayedValBinding = this.setup_hoo_binding_from_json( 'playedValueBinding' );

		// remember! the alert stuff doesnt work in ie
		//mwah this._mouseClickAction = this.setup_hoo_action_from_json( 'mouseClickAction' );

		// when the headless player changes played amount, it causes our local value to animate, which we observe, and set the bar width accordingly
		this.addObserver('_playedAmount', this, this._playDidChange );
		this.addObserver('_loadedAmount', this, this._loadDidChange );
		this._playDidChange(null,null);	// make sure they draw at zero
		this._loadDidChange(null,null);
	},


	// we observed a change!
	// If no binding is found this gets called anyway? So assume default is on?
	readyDidChange: function( target, property ) {

		//pbtarget.removeObserver( property, this, this.readyDidChange );
		// handle disable as well as enable?

		// why does this seem to be
		if( target.get(property) ) {
			this._buttonSMControl.sendEvent( "ev_showState1" );
		}
	},

	// our local value changed - could/should do this with SC bindings?
	_playDidChange: function( target, property ) {
		var playDivWidth = this._maxBarWidth*this._playedAmount;
		// console.log("playDivWidth                     "+playDivWidth+" "+this._playedAmount);
		if(playDivWidth<0)
			debugger;
		this._playProgressDiv.width( playDivWidth );
	},

	// our local value changed (was animated to new value)
	_loadDidChange: function( target, property ) {
		var loadDivWidth = this._maxBarWidth*this._loadedAmount;
		// console.log("LoadDivWidth = "+this._maxBarWidth);
		this._loadProgressDiv.width(loadDivWidth);
	},

	/* we observed a change! - notification callback */
	maxAmountDidChange:  function( target, property ) {
		var updatedVal =  target[property];
		this.set( '_maxAmount', updatedVal );
		this.recalcLoadedAndPlayedAmounts();
	},


	/* we observed a change in the headless player! - notification callback */
	loadedDidChange: function( target, property ) {
		var percent = ABoo.HooMath.xAsUnitPercentOfY( target[property], this._maxAmount );
		if(percent<0)
			debugger
		if(percent==0)
			this.coldSetProperty( '_loadedAmount', percent );
		else
			this.animateProperty( '_loadedAmount', percent, 1000/25*8 );
	},

	/* we observed a change in the headless player! - notification callback */
	playedDidChange: function( target, property ) {
		var updatedAmount = target[property];
		var percent = ABoo.HooMath.xAsUnitPercentOfY( updatedAmount, this._maxAmount );

		if(percent==0)
			this.coldSetProperty( '_playedAmount', percent );
		else
			this.animateProperty( '_playedAmount', percent, 1000/25*8 );
	},


	recalcLoadedAndPlayedAmounts: function() {
		this.coldSetProperty( '_playedAmount', this._playedAmount );
		this.coldSetProperty( '_loadedAmount', this._loadedAmount );
	},

	parentDidResize: function() {

		//if(Modernizr.canvas!==undefined)
		if(this._started===true)
			this.resizeAll();
		//}
	},

	resizeAll: function() {

		var newWidth = this.div$.width();
		var newHeight = this.div$.outerHeight();
		//var currentWidth = this._$canvas.width();
		//var currentHeight = this._$canvas.outerHeight();

		//console.log("resize "+newWidth);

		if( newWidth!=this._currentWidth || newHeight!=this._currentHeight ) {

			this._barberPole.setSize( newWidth, newHeight );

			this._maxBarWidth = newWidth-4;
			var maxBarHeight = newHeight-4;

			this.recalcLoadedAndPlayedAmounts();

			this._currentWidth = newWidth;
			this._currentHeight = newHeight;
		}
	},


	toggleBusy: function() {
		this._barberPole.toggleBusy();
	}


});

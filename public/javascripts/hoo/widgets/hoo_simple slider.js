ABoo.BusyFadeHelper = SC.Object.extend({

	_fadeTimeStart: undefined,
	_fadeTimeEnd: undefined,
	_fadeStartVal: undefined,
	_fadeEndVal: undefined,
	_fadeComplete: undefined,
	_target: undefined,
	_property: undefined,
	_ended: undefined,

	animate: function( target, property, endVal, duration, completeCallback ) {
		this._target = target;
		this._property = property;
		this._fadeStartVal = target.get(property);
		this._fadeEndVal = endVal;
		this._fadeTimeStart = new Date().getTime();
		this._fadeTimeEnd = this._fadeTimeStart+duration;
		this._fadeComplete = completeCallback;
		this._ended = false;
	},

	update: function (time) {

		if(this._ended) {
			this._didEnd();
			return;
		}

		var updatedVal;
		if(time>this._fadeTimeEnd) {
			updatedVal=this._fadeEndVal;
			this._ended = true;	// defer completion till next cycle (so we are certain to draw the end state)
		} else {
			updatedVal = ABoo.HooMath.lerp( this._fadeTimeStart, this._fadeStartVal, this._fadeTimeEnd, this._fadeEndVal, time );
		}
		//console.log("fade "+updatedVal);
		if(isNaN(updatedVal))
			debugger;
		this._target.set( this._property, updatedVal );
	},

	_didEnd: function() {
		//console.log("doing callback");
		this._fadeComplete();
		this._fadeComplete = null;
	}
});


/*
 *
*/
ABoo.BarberPoleSprite = ABoo.HooSprite.extend({
	spriteDraw: function( ctx, x, y, width, height, percent, busyAlpha ) {

		ctx.save();

		ctx.setTransform(1, 0, 0, 1, 0, 0);
		ctx.clearRect(x,y,width,height);
		ctx.globalAlpha = 1.0;
		ctx.globalCompositeOperation = 'source-over';

		// draw the background
		//ctx.fillStyle = "rgba(100,100,100,1)";
		//ctx.fillRect(0,0,width,height);

		// draw the slanty rects
		//putback if( this._busyFadeHelper._showBusy===true ) {

			ctx.save();

			ctx.beginPath();
			ctx.rect(0, 0, width-4, height);
			ctx.closePath();
			ctx.clip();

			//putback this._busyFadeHelper.step();
			// console.log("alpha is "+busyAlpha+", percent is"+percent);
			ctx.fillStyle = "rgba(170,160,160,"+busyAlpha+")";

			var barWidth = 5;
			var barSpace = 10;
			var numberOfBars = width/barSpace;

			var maxOffset = 10;
			var xDisplacement = maxOffset*percent;

			var x = -barWidth;
			for( var i=0; i<numberOfBars; i++ ) {

				// offset each slanty rect
				// the transform seems to mess up the clip rect th ctx.setTransform(1, 0, 0, 1, x, 0);
				ctx.beginPath();

				// draw a slanty recty
				ctx.moveTo( x+ xDisplacement, 0 );
				ctx.lineTo( x+ xDisplacement+barWidth, 0 );
				ctx.lineTo( x+ xDisplacement+barWidth-barWidth, height-4 );
				ctx.lineTo( x+ xDisplacement-barWidth, height-4 );
				ctx.closePath();
				ctx.fill();
				x = x+barSpace;
			}

			ctx.restore();
		//putback}

		// draw a grad over the top
		//ctx.setTransform(1, 0, 0, 1, 0, 0);
		//ctx.beginPath();
		//ctx.rect(0, 0, width, height);

		//ctx.globalCompositeOperation = 'lighter';
		//gradient = ctx.createLinearGradient(0, height, 0, 0);
		//gradient.addColorStop(1.0, "rgba(235, 235, 235, 0.3)");
		//gradient.addColorStop(0, "rgba(0, 0, 0, 0.1)");
		//ctx.fillStyle = gradient;
		//ctx.fill();

		ctx.restore();
	}
});


/*
 *
*/
ABoo.HooBarberPoleGraphic = SC.Object.extend( ABoo.HooCanvasViewMixin, {

	_barberPoleSprite: undefined,
	_isBusy: false,
	_lastUpdateTime:undefined,
	_percent:0,

	// fade experiment
	_fadeAlpha: 0,
	_fadeHelper: undefined,

	init: function( /* init never has args */ ) {
		this._super();
		this._barberPoleSprite = ABoo.BarberPoleSprite.create();

	},

	// canvas -> HooCanvasViewMixin
	drawContents: function( ctx, width, height ) {
		this._barberPoleSprite.spriteDraw( ctx, 0, 0, width, height, this._percent, this._fadeAlpha );
	},

	toggleBusy: function() {
		//console.log("Togglwing busy");
		this._isBusy = !this._isBusy;
		if(this._isBusy) {
			//console.log("fade on");
			if( !this._fadeHelper )
				this._fadeHelper = ABoo.BusyFadeHelper.create();

			var self = this;
			var fadeComplete = function() {
				//alert("dicky "+self);
			};
			this._fadeHelper.animate( this, '_fadeAlpha', 1, 1000/25*10, fadeComplete );

			this._lastUpdateTime = -1;

			ABoo.ShiteDisplayLink.sharedDisplayLink.registerListener(this);

		} else {
			//console.log("fade off");
			if( !this._fadeHelper )
				this._fadeHelper = ABoo.BusyFadeHelper.create();

			var self = this;
			var fadeComplete = function() {
				ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener(self);
			};
			this._fadeHelper.animate( this, '_fadeAlpha', 0, 1000/25*10, fadeComplete );
		}
		this._parentCanvas.setNeedsDisplay();
	},

	timeUpdate: function( time ) {
		if(this._lastUpdateTime!=-1) {

			if( this._fadeHelper ) {
				this._fadeHelper.update(time);
				if( this._fadeHelper._fadeComplete==null ) {
					this._fadeHelper = null;
					return;
				}
			}
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
ABoo.HooSimpleSlider = ABoo.HooFormButtonSimple.extend({

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

	/* we observed a change! - notification callback */
	maxAmountDidChange:  function( target, property ) {
		var updatedVal =  target[property];
		this.set( '_maxAmount', updatedVal );
		this.recalcLoadedAndPlayedAmounts();
	},


	/* we observed a change! - notification callback */
	loadedDidChange: function( target, property ) {
		var percent = ABoo.HooMath.xAsUnitPercentOfY( target[property], this._maxAmount );
		this.setLoadAmount(percent);
	},

	/* we observed a change! - notification callback */
	playedDidChange: function( target, property ) {
		var updatedAmount = target[property];
		var percent = ABoo.HooMath.xAsUnitPercentOfY( updatedAmount, this._maxAmount );
		//console.log("Played "+updatedAmount+" "+percent );
		this.setPlayAmount(percent);
	},


	recalcLoadedAndPlayedAmounts: function() {
		this.setPlayAmount(this._playedAmount);
		this.setLoadAmount(this._loadedAmount);
	},

	// could/should do this with SC bindings?
	setPlayAmount: function( arg ) {
		this.set( '_playedAmount', arg );
		var playDivWidth = this._maxBarWidth*this._playedAmount;
		this._playProgressDiv.width( playDivWidth );
	},

	setLoadAmount: function( arg ) {
		this.set( '_loadedAmount', arg );
		var loadDivWidth = this._maxBarWidth*this._loadedAmount;
		// console.log("LoadDivWidth = "+this._maxBarWidth);
		this._loadProgressDiv.width(loadDivWidth);
	},

	//mwah  getClickableItem: function() {
	//mwah 	alert("oh really?");
	//mwah 	return  this.getFirstDomItemOfType(".slider");
	//mwah },

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

	//startBusy: function() {

	//	var self = this;
		//mwah this._busyFadeHelper._animFunction = function() {
			//mwah var ctx = self._$canvas[0].getContext('2d');
			//mwah self.draw(ctx, self.div$.width(), self.div$.outerHeight());
			//mwah self._currentTime = (self._currentTime + self._timeStep) % 1000;
		//mwah }
		//mwah this._busyFadeHelper.begin( self._timeStep );
	//},

	//stopBusy: function() {
		//mwah this._busyFadeHelper.end();
	//},


	// wtf is this?
	//temporarySetEnabledState: function( stateIndex, enabled ) {
	//	alert("wtf");
	//},
	//enableButton: function( stateIndex ) {
	//	alert("wtf");
	//},
	//showMouseUpState: function( stateIndex ) {
	//	alert("wtf");
	//	alert("woo mouse up");
	//},
	//showMouseDownState: function( stateIndex ) {
	//	alert("wtf");
	//	if(this._mouseClickAction) {
	//		var newPos = this.localXPosition();
	//		this._lastDragXAmount = newPos;
	//		console.log("click at pos "+newPos);
	//		this._mouseClickAction.a.call( this._mouseClickAction.t, newPos );
	//	}
	//},
	//mouseDragged: function(e){
	//	alert("wtf");
	//	if(this._mouseClickAction) {
	//		var xamount = this.localXPosition();  // IE fires mouse events continuously even when it doesn't move more than 1 pixel
	//		if( xamount!=this._lastDragXAmount) {
	//			this._mouseClickAction.a.call( this._mouseClickAction.t, xamount );
	//			this._lastDragXAmount = xamount;
	//		}
	//	}
	//},

	//fireAction: function( nextState, argsHash ) {
	//	alert("wtf");

	//	argsHash.onCompleteAction.call( argsHash.onCompleteTarget );
	//},

	// convert mouse coord to slider position
	//localXPosition: function(){
	//	alert("wtf");

	//	if(this._stateMachine.lastWindowEvent) {
	//		var x = this._stateMachine.lastWindowEvent.pageX;
	//		var y = this._stateMachine.lastWindowEvent.pageY;
	//		var pos = this._loadProgressDiv.offset();
	//		var xval;
	//		// var size = [this._loadProgressDiv.width(), this._loadProgressDiv.height()];
	//		if( pos.left>x )
	//			xval = 0;
	//		else if((pos.left + this._maxBarWidth)<x)
	//			xval = 1;
	//		else
	//			xval = (x-pos.left)/this._maxBarWidth;
	//		if(xval > this._loadedAmount)
	//			xval  = this._loadedAmount
	//		return xval;
	//	}
	//	return -1;
	//}

});



ABoo.HooRadialProgressGraphic = SC.Object.extend( ABoo.HooCanvasViewMixin, {

	_donutTestSprite: undefined,
	_busyAngle: -1,
	_outerRad: 1.0,
	_innerRad: 0.5,
	_loadProgess: 0,
	_playProgress: 0,
	_isBusy: false,
	_lastUpdateTime:undefined,

	init: function( /* init never has args */ ) {
		this._super();
		this._donutTestSprite = ABoo.DonutTestSprite.create();
	},

	// canvas -> HooCanvasViewMixin
	drawContents: function( ctx, width, height ) {
			// ctx.fillStyle = "rgba(100,100,100,1)";
			// ctx.fillRect(0,0,width,height);
			this._donutTestSprite.spriteDraw( ctx, 0, 0, width, height, this._busyAngle, this._outerRad, this._innerRad, this._loadProgess, this._playProgress );
	},

	setLoadProgress: function( degrees ) {
		this._loadProgess = degrees;
		this._parentCanvas.setNeedsDisplay();
	},
	setPlayProgress: function( degrees ) {
		this._playProgress = degrees;
		this._parentCanvas.setNeedsDisplay();
	},
	toggleBusy: function() {
		//console.log("Togglwing busy");
		this._isBusy = !this._isBusy;
		if(this._isBusy) {
			this._busyAngle = 0;
			this._lastUpdateTime = -1
			ABoo.ShiteDisplayLink.sharedDisplayLink.registerListener(this);
		} else {
			this._busyAngle = -1;
			ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener(this);
		}
		this._parentCanvas.setNeedsDisplay();
	},
	setIsBusy: function(flag) {
		if(this._isBusy!=flag)
			this.toggleBusy();
	},
	timeUpdate: function( time ) {

		if(this._lastUpdateTime!=-1) {
			var dist = time-this._lastUpdateTime;
			this._busyAngle = this._busyAngle + 360*0.7/1000*dist;
			this._parentCanvas.setNeedsDisplay();
		}
		this._lastUpdateTime = time;
	}
});

/*
 *
*/
ABoo.HooRadialProgress = ABoo.HooWidget.extend({

	_hooCanvas: undefined,
	_progressGraphic:undefined,
	sliderValue: 0,

	init: function( /* init never has args */ ) {
		this._super();
		this._progressGraphic = ABoo.HooRadialProgressGraphic.create( {_outerRad:this.json.outerRad, _innerRad:this.json.innerRad} );
	},

	setupDidComplete: function() {
		HOO_nameSpace.assert( this._hooCanvas, "this button must be added to a canvas to work" );
		this._hooCanvas.addSubview( this._progressGraphic );

		// example of setting up a binding
		var BINDINGSTEST = false;
		if(BINDINGSTEST) {
			var debugOnly = ABoo.SimpleCounterForBindingsDebugging.create({_rate:1000});

			debugOnly.addObserver('_counter', this, this.loadDidChange );
			debugOnly.addObserver('_flag', this, this.busyDidChange );
		}

	},

	toggleBusy: function() {
		this._progressGraphic.toggleBusy();
	},
	// for binding - kinda boilerplate - TODO! get rid
	busyDidChange: function (sender, key) {
		this._progressGraphic.setIsBusy(sender.get(key));
	},

	setLoadProgress: function( degrees ) {
		this._progressGraphic.setLoadProgress(parseFloat(degrees));
	},

	// for binding - kinda boilerplate - TODO! get rid
	loadDidChange: function (sender, key) {
		this.setLoadProgress(sender.get(key));
	},

	setPlayProgress: function( degrees ) {
		this._progressGraphic.setPlayProgress(parseFloat(degrees));
	},

	// for binding - kinda boilerplate - TODO! get rid
	playDidChange: function (sender, key) {
		this.setPlayProgress(sender.get(key));
	},

	// for binding - kinda boilerplate - TODO! get rid
	playDidChange: function (sender, key) {
		this.setPlayProgress(sender.get(key));
	}

});

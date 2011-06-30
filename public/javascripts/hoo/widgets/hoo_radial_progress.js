ABoo.DonutTestSprite = ABoo.HooSprite.extend({

	_loadColor:"rgba(170,170,170,0.8)",
	_playColor:"rgba(247,163,0,1.0)",
	_busyColor:"#FF00ff",

	spriteDraw: function( ctx, x, y, width, height, busyAngle, outerRad, innerRad, loadAmt, playAmt ) {

		outerRad = typeof(outerRad)!='undefined' ? outerRad : 1.0;
		innerRad = typeof(innerRad)!='undefined' ? innerRad : 0.5;
		loadAmt = typeof(loadAmt)!='undefined' ? loadAmt : 0;
		playAmt = typeof(playAmt)!='undefined' ? playAmt : 0;

		ctx.save();

			// var newCanvas = $("<canvas></canvas>")[0];
			// var newContext = newCanvas.getContext('2d');
			// newCanvas.width = width;
			// newCanvas.height = height;

			var loadingRotAmount = loadAmt/360.0 * Math.PI*2.0;
			var playingRotAmount = playAmt/360.0 * Math.PI*2.0;

			var busySpinnerAngle = busyAngle % 360 * Math.PI/180.0;
			HOO_nameSpace.assert( loadingRotAmount>=playingRotAmount, "Go on, explain to me how this happened.");

			var outerRadius = width/2.0 * outerRad;
			var innerRadius = width/2.0 * innerRad;

			var centrePt = [width/2.0, height/2.0];
			var startAngle = -Math.PI/2.0;
			var busySpinnerWidth = Math.PI/6.0;
			var playingEndAngle = startAngle+playingRotAmount;
			var busyStartAngle = busySpinnerAngle-busySpinnerWidth/2.0;
			var busyEndAngle = busySpinnerAngle+busySpinnerWidth/2.0;

			ctx.globalCompositeOperation = 'source-over';

			// loading amount
			ctx.fillStyle = this._loadColor;
			ctx.beginPath();
			ctx.moveTo(centrePt[0], centrePt[1]);
			var loadingEndAngle = startAngle+loadingRotAmount;
			ctx.arc(centrePt[0], centrePt[1], outerRadius, startAngle, loadingEndAngle, false);
			ctx.closePath();
			ctx.fill();

			// playing amount
			ctx.fillStyle = this._playColor;
			ctx.beginPath();
			ctx.moveTo(centrePt[0], centrePt[1]);
			var playingEndAngle = startAngle+playingRotAmount;
			ctx.arc(centrePt[0], centrePt[1], outerRadius, startAngle, playingEndAngle, false);
			ctx.closePath();
			ctx.fill();

			// busy spinner
			if(busyAngle!=-1)
			{
				var dist = (outerRadius-innerRadius);
				var pt1 = [centrePt[0]+dist,centrePt[1]];
				//var pt2 = [centrePt[0]+innerRadius,centrePt[1]];

				var px1 = Math.cos(busyEndAngle)*(pt1[0]-centrePt[0]) - Math.sin(busyEndAngle) * (pt1[1]-centrePt[1]) + centrePt[0];
				var py1 = Math.sin(busyEndAngle)*(pt1[0]-centrePt[0]) + Math.cos(busyEndAngle) * (pt1[1]-centrePt[1]) + centrePt[1];
				var px2 = Math.cos(busyStartAngle)*(pt1[0]-centrePt[0]) - Math.sin(busyStartAngle) * (pt1[1]-centrePt[1]) + centrePt[0];
				var py2 = Math.sin(busyStartAngle)*(pt1[0]-centrePt[0]) + Math.cos(busyStartAngle) * (pt1[1]-centrePt[1]) + centrePt[1];

				var bufferingGradient = ctx.createLinearGradient( px1, py1, px2, py2 );
				bufferingGradient.addColorStop(0, this._busyColor);
				bufferingGradient.addColorStop(1, "rgba(255,255,0,0)");

				ctx.fillStyle = bufferingGradient;
				ctx.beginPath();
				ctx.moveTo(centrePt[0], centrePt[1]);
				ctx.arc(centrePt[0], centrePt[1], outerRadius, busyStartAngle, busyEndAngle, false);
				ctx.closePath();
				ctx.fill();
			}

			// punch out the center hole
			ctx.globalCompositeOperation = 'destination-out';

			ctx.fillStyle = "#000";
			ctx.beginPath();
			ctx.moveTo(centrePt[0], centrePt[1]);
			ctx.arc(centrePt[0], centrePt[1], innerRadius, 0, Math.PI*2, false);
			ctx.closePath();
			ctx.fill();

			// ctx.drawImage(newCanvas, 0, 0);

		ctx.restore();
	}
});

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
		console.log("Togglwing busy");
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

});

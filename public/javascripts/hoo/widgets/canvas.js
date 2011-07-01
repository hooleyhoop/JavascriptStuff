
ABoo.HooCanvas = ABoo.HooWidget.extend({

	_$canvas: undefined,
	_subViews: undefined,
	_isDirty: false,
	_isActive: false,
	_lastDirtyTime: false,

	init: function( /* init never has args */ ) {
		this._super();

		if( this._$canvas==undefined )
			this._$canvas = this.getFirstDomItemOfType("canvas");
		HOO_nameSpace.assert( this._$canvas );
		this._subViews = new Array();
	},

	_setSize: function( width, height ) {
		if( width!=this.width() || height!=this.height() ) {
			this._$canvas.attr({ width:width, height:height }); // setting the size resets the canvas
			this.setNeedsDisplay();
		}
	},

	parentDidResize: function() {
		if( ABoo.browserSupportsCanvas() ){
		//	if(this._started===true)
			var newWidth = this.div$.parent().parent().width();
			var newHeight = this.div$.parent().parent().height();
			//console.log(newWidth+" "+newHeight);
			this._setSize(newWidth,newHeight);
		}
	},

	ctx: function() {
		var ctx = this._$canvas[0].getContext('2d');
		return ctx;
	},

	width: function() {
		var a = this._$canvas.width();
		// var b = this._$canvas.outerWidth();
		//HOO_nameSpace.assert( a==b, "what really????");
		return a;
	},

	height: function() {
		var a = this._$canvas.height();
		//var b = this._$canvas.outerHeight();
		//HOO_nameSpace.assert( a==b, "what really????");
		return a;
	},

	setNeedsDisplay: function() {
		this._isDirty = true;
		this._lastDirtyTime = (new Date()).getTime();
		if(!this._isActive) {
			ABoo.ShiteDisplayLink.sharedDisplayLink.registerCanvas(this);
			this._isActive = true;
		}
	},

	addSubview: function( child ) {
		console.warn("ADD "+child);
		this._subViews.push( child );
		child._parentCanvas = this;
	},

	removeAllSubviews: function() {
		var self = this;
		var newViewList = this._subViews.slice(); //jQuery.extend({}, this._subViews);
		// .. to avoid mutating the array while enumarting contents..
		$.each( newViewList, function(indexInArray, valueOfElement){
			console.warn("REMOVE "+valueOfElement);
			self.removeSubview( valueOfElement );
		});
	},

	removeSubview: function( child ) {
		var i = this._subViews.indexOf(child);
		if(i>-1) {
			this._subViews.splice(i,1);
			child._canvas = null;
		}
		if(this._subViews.length==0 && this._isActive) {
			ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterCanvas(this);
			this._isActive = false;
		}
	},

	displayUpdate: function( time ) {
		if( this._isDirty ) {

			var ctx = this.ctx();
			ctx.setTransform(1, 0, 0, 1, 0, 0);
			ctx.clearRect(0,0,this.width(),this.height());
			ctx.globalAlpha = 1.0;
			ctx.globalCompositeOperation = 'source-over';

			//ctx.fillStyle = "rgba(100,100,100,1)";
			//ctx.fillRect(0,0,width,height);

			$.each( this._subViews, function(indexInArray, valueOfElement){
				//console.warn( "debugging: "+ valueOfElement.drawInRect );
				valueOfElement.drawInRect( time );
			});
			this._isDirty = false;
		} else {
			var timeSince = time - this._lastDirtyTime;
			if( timeSince > 3000 ) {
				ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterCanvas(this);
				this._isActive = false;
			}
		}
	}
});



ABoo.HooCanvasViewMixin = SC.Mixin.create({
	_parentCanvas: undefined,

	drawInRect: function( t ) {
		this.drawNow( this._parentCanvas.ctx(), this._parentCanvas.width(), this._parentCanvas.height() );
	},
	drawNow: function( ctx, width, height ) {
		ctx.save();
			this.drawContents( ctx, width, height );
		ctx.restore();
	}
});

ABoo.SpeechBubbleBottom = SC.Object.extend({
});

// SpeechBubbleBottom.mixin({
var SpeechBubbleBottomClassMethods = {

	draw: function( ctx, x, y, width, height, cornerRad, nubbinWidth, nubbinHeight ) {

		var anticlockwise = true;
		var south = Math.PI/2;
		var east = 0;
		var west = Math.PI;
		var north = Math.PI*3/2;

		// antio- clockwise origin top left
		var penx = x;
		var peny = y+cornerRad;
		ctx.moveTo( penx, peny );
		peny += height-cornerRad-cornerRad-nubbinHeight;
		ctx.lineTo( penx, peny );

		// bottom left corner
		ctx.arc( penx+cornerRad, peny, cornerRad, west, south, anticlockwise );

		// to nubbin
		penx += nubbinWidth;
		peny += cornerRad;
		ctx.lineTo(penx, peny);

		// nubbin pt
		penx += nubbinWidth/2;
		peny += nubbinHeight;
		ctx.lineTo(penx, peny);

		penx += nubbinWidth/2;
		peny -= nubbinHeight;
		ctx.lineTo(penx, peny);

		penx += width-cornerRad-nubbinWidth-nubbinWidth;
		peny += 0;
		ctx.lineTo(penx, peny);

		// bottom right corner
		peny -= cornerRad;
		ctx.arc( penx, peny, cornerRad, south, east, anticlockwise );

		penx += cornerRad;
		peny -= height-cornerRad-cornerRad-nubbinHeight;
		ctx.lineTo( penx, peny );

		// top right
		penx -= cornerRad;
		ctx.arc( penx, peny, cornerRad, east, north, anticlockwise );

		penx -= width-cornerRad-cornerRad;
		peny -= cornerRad;
		ctx.lineTo( penx, peny );

		// top left
		peny += cornerRad;
		ctx.arc( penx, peny, cornerRad, north, west, anticlockwise );
	}
};

SC.mixin( ABoo.SpeechBubbleBottom, SpeechBubbleBottomClassMethods );

ABoo.RoundedRectangle = SC.Object.extend({
});

// RoundedRectangle.mixin({
var RoundedRectangleClassMethods = {

	draw: function( ctx, x, y, width, height, r ) {

		ctx.beginPath();

		var p1 = [x,y];					// top left
		var p2 = [x+width, y];			// top right
		var p3 = [p2[0], y+height];		// bottom right
		var p4 = [p1[0], p3[1]];		// bottom left

		// anti-clockwise origin top left

		if(r==0) {
			ctx.moveTo( p1[0], p1[1] );
			ctx.lineTo( p4[0], p4[1] );
			ctx.lineTo( p3[0], p3[1] );
			ctx.lineTo( p2[0], p2[1] );
		} else {

			var anticlockwise = true;
			var south = Math.PI/2;
			var east = 0;
			var west = Math.PI;
			var north = Math.PI*3/2;

			var q1 = [ p1[0], p1[1]+r ];
			var q2 = [ p4[0], p4[1]-r ];
			var q3 = [ p4[0]+r, p4[1] ];
			var q4 = [ p3[0]-r, p3[1] ];
			var q5 = [ p3[0], p3[1]-r ];
			var q6 = [ p2[0], p2[1]+r ];
			var q7 = [ p2[0]-r, p2[1] ];
			var q8 = [ p1[0]+r, p1[1] ];

			ctx.moveTo( q1[0], q1[1] );
			ctx.lineTo( q2[0], q2[1] );

			// bottom left corner
			ctx.arc( q2[0]+r, q2[1], r, west, south, anticlockwise );

			ctx.lineTo( q3[0], q3[1] );
			ctx.lineTo( q4[0], q4[1] );

			// bottom right corner
			ctx.arc( q4[0], q4[1]-r, r, south, east, anticlockwise );

			ctx.lineTo( q5[0], q5[1] );
			ctx.lineTo( q6[0], q6[1] );

			// top right
			ctx.arc( q6[0]-r, q6[1], r, east, north, anticlockwise );

			ctx.lineTo( q7[0], q7[1] );
			ctx.lineTo( q8[0], q8[1] );

			// top left
			ctx.arc( q8[0], q8[1]+r, r, north, west, anticlockwise );

			ctx.lineTo( q1[0], q1[1] );
		}
		ctx.closePath();
	}
};
SC.mixin( ABoo.RoundedRectangle, RoundedRectangleClassMethods );


ABoo.RoundedTriangle = SC.Object.extend({
});

var RoundedTriangleClassMethods = {

	draw: function( ctx, x, y, width, height, r ) {

		var height_over_2 = height/2.0;
		var h1 = Math.sqrt( width*width+height_over_2*height_over_2);
		var sinTheta = height_over_2 / h1;
		var theta = Math.asin(sinTheta);
		var gamma = Math.PI/2.0 - theta;
		var sinGamma = Math.sin(gamma);
		var CD = r / sinTheta;
		var BD = CD + r;
		var AB = BD / sinGamma * sinTheta;
		var IJ = sinTheta * r;
		var DI = sinGamma * r;
		var startx = x;
		var starty = y;

		var T1 = [startx, starty];
		var T2 = [T1[0]+width, T1[1]+height_over_2];
		var T3 = [T1[0], T1[1]+height];

		var p1 = [T1[0], T1[1]+AB];
		var p9 = [T3[0], T3[1]-AB];
		var p5 = [T2[0] -CD, T2[1]];
		var p2 = [p1[0]+r, p1[1]];
		var p3 = [p2[0]+IJ, p2[1]-DI];
		var p4 = [p5[0]+IJ, p5[1]-DI];
		var p6 = [p5[0]+IJ, p5[1]+DI];
		var p8 = [p9[0]+r, p9[1]];
		var p7 = [p8[0]+IJ, p8[1]+DI];

			// full triangle
			//fillStyle = "rgba(100,100,100,0.5)";
			//beginPath();
			//	moveTo( T1[0], T1[1] );
			//	lineTo( T2[0], T2[1] );
			//	lineTo( T3[0], T3[1] );
			//	lineTo( T1[0], T1[1] );
			//	closePath();
			//fill();

			// circles
			// fillStyle = "rgba(255,0,0,1)";
			// beginPath();
			//	moveTo( p2[0], p2[1] );
			//	arc( p2[0], p2[1], r, 0, 2*Math.PI, false);
			//	moveTo( p5[0], p5[1] );
			//	arc( p5[0], p5[1], r, 0, 2*Math.PI, false);
			//	moveTo( p8[0], p8[1] );
			//	arc( p8[0], p8[1], r, 0, 2*Math.PI, false);
			// closePath();
			// fill();

			var topArcAngle = Math.PI - gamma;
			//var rightArcAngle = gamma*2.0;


			// lets try arc on top circle
			//beginPath();
			//	moveTo( p2[0], p2[1] );
			//	arc( p2[0], p2[1], r, Math.PI, Math.PI+topArcAngle, false);
			//closePath();
			//fill();

			// lets try arc on bottom circle
			//beginPath();
			//	moveTo( p8[0], p8[1] );
			//	arc( p8[0], p8[1], r, Math.PI, Math.PI-topArcAngle, true);
			//closePath();
			//fill();

			// lets try arc on right circle
			//beginPath();
			//	moveTo( p5[0], p5[1] );
			//	arc( p5[0], p5[1], r, Math.PI+topArcAngle, Math.PI-topArcAngle, false);
			//closePath();

		ctx.beginPath();
		if(r==0) {
			ctx.moveTo( T1[0], T1[1] );
			ctx.lineTo( T2[0], T2[1] );
			ctx.lineTo( T3[0], T3[1] );
			ctx.lineTo( T1[0], T1[1] );

		} else {
			var topArcAngle = Math.PI - gamma;
			// var rightArcAngle = gamma*2.0;

			ctx.moveTo( p1[0], p1[1] );
			//lineTo( p2[0], p2[1] );
			//lineTo( p3[0], p3[1] );
			ctx.arc( p2[0], p2[1], r, Math.PI, Math.PI+topArcAngle, false);
			ctx.lineTo( p4[0], p4[1] );
			//lineTo( p5[0], p5[1] );
			//lineTo( p6[0], p6[1] );
			ctx.arc( p5[0], p5[1], r, Math.PI+topArcAngle, Math.PI-topArcAngle, false);
			ctx.lineTo( p7[0], p7[1] );
			//lineTo( p8[0], p8[1] );
			//lineTo( p9[0], p9[1] );
			ctx.arc( p8[0], p8[1], r, Math.PI-topArcAngle, Math.PI, false);
			ctx.lineTo( p1[0], p1[1] );
		}
		ctx.closePath();
	}
};
SC.mixin( ABoo.RoundedTriangle, RoundedTriangleClassMethods );


ABoo.Graphics = SC.Object.extend({
});

// Graphics.mixin({
var GraphicsClassMethods = {

	roundedTriangle: ABoo.RoundedTriangle,
	roundedRect: ABoo.RoundedRectangle,
	speechBubble_bottom: ABoo.SpeechBubbleBottom
};
SC.mixin( ABoo.Graphics, GraphicsClassMethods );


ABoo.HooSprite = SC.Object.extend({

	setPropertiesOfSprite: function( propertyDict ) {
		for (var key in propertyDict) {
			var shouldBeValue = propertyDict[key];
			this.set(key,shouldBeValue);
		}
	}
});

ABoo.PlayButtonSprite = ABoo.HooSprite.extend({
	_isDisabled: true,
	_isDown: false,

	spriteDraw: function( ctx, x, y, width, height ) {

		var graphicToDraw = "roundedTriangle";

		ctx.save();

			var innerCol, innerinnerCol, shadowCol, my_gradient;

			if( this._isDisabled ) {
				innerCol = "#88a380";
				innerinnerCol = "#7d9876";
				shadowCol = null;
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(0, "rgba(230,230,230,1)");
				my_gradient.addColorStop(1, "rgba(230,230,230,0.5)");
			} else if( this._isDown ) {
				innerCol = "#4a6150";
				innerinnerCol = "#248541";
				shadowCol = null;
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(1, "rgba(150,150,150,0.8)");
				my_gradient.addColorStop(0.5, "rgba(100,100,100,0.3)");
				my_gradient.addColorStop(0, "rgba(0,0,0,0.1)");
			} else {
				innerCol = "#5EBB47";
				innerinnerCol = "#39B54A";
				shadowCol = "rgba(0,0,0,0.3)";
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(0, "rgba(170,170,170,0.9)");
				my_gradient.addColorStop(0.5, "rgba(170,170,170,0.3)");
				my_gradient.addColorStop(1, "rgba(0,0,0,0)");
			}

			var tenPercentOfWidth = width / 10.0;
			var tri3Rect = [x,y,width,height];
			tri3Rect = ABoo.VectorMath.inflateRect( tri3Rect, -tenPercentOfWidth, -tenPercentOfWidth );
			tri3Rect = ABoo.VectorMath.offsetRect( tri3Rect, [tenPercentOfWidth, 0] );
			var triangle3PtArray = ABoo.VectorMath.trianglePtArrayFromRect( tri3Rect );

			var triangle2PtArray = ABoo.VectorMath.offsetPolygon( triangle3PtArray, tenPercentOfWidth );
			var tri2Rect = [ triangle2PtArray[0][0], triangle2PtArray[0][1], triangle2PtArray[1][0]-triangle2PtArray[0][0], triangle2PtArray[2][1]-triangle2PtArray[0][1] ];

			var triangle1PtArray = ABoo.VectorMath.offsetPolygon( triangle2PtArray, tenPercentOfWidth );
			var tri1Rect = [ triangle1PtArray[0][0], triangle1PtArray[0][1], triangle1PtArray[1][0]-triangle1PtArray[0][0], triangle1PtArray[2][1]-triangle1PtArray[0][1] ];

			ctx.fillStyle = my_gradient;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri3Rect[0], tri3Rect[1], tri3Rect[2], tri3Rect[3], tenPercentOfWidth );
			ctx.fill();
			//ctx.strokeStyle = "#000";
			//	ABoo.Graphics[graphicToDraw].draw( ctx, tri3Rect[0], tri3Rect[1], tri3Rect[2], tri3Rect[3], 0 );
			//ctx.stroke();

			ctx.shadowColor = shadowCol;
			ctx.shadowBlur = 4;
			ctx.shadowOffsetX = 0;
			ctx.shadowOffsetY = tenPercentOfWidth/10;

			ctx.fillStyle = innerCol;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri2Rect[0], tri2Rect[1], tri2Rect[2], tri2Rect[3], tenPercentOfWidth/2.0 );
			ctx.fill();
			//ctx.strokeStyle = "#000";
			//	ABoo.Graphics[graphicToDraw].draw( ctx, tri2Rect[0], tri2Rect[1], tri2Rect[2], tri2Rect[3], 0 );
			//ctx.stroke();

			ctx.shadowColor= undefined;
			ctx.shadowBlur = undefined;

			ctx.fillStyle = innerinnerCol;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri1Rect[0], tri1Rect[1], tri1Rect[2], tri1Rect[3], 0 );
			ctx.fill();

		ctx.restore();
	}
});


ABoo.PauseButtonSprite = ABoo.HooSprite.extend({
	_isDown: false,

	spriteDraw: function( ctx, x, y, width, height ) {

		var graphicToDraw = "roundedRect";
		var innerCol, innerinnerCol, shadowCol, my_gradient;

		if( this._isDown ) {
			innerCol = "#0f6391";
			innerinnerCol = "#005FAE";
			shadowCol = null;
			my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			my_gradient.addColorStop(1, "rgba(150,150,150,0.8)");
			my_gradient.addColorStop(0.5, "rgba(100,100,100,0.3)");
			my_gradient.addColorStop(0, "rgba(0,0,0,0.1)");
		} else {
			innerCol = "#0080C7";
			innerinnerCol = "#005FAE";
			shadowCol = "rgba(0,0,0,0.3)";
			my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			my_gradient.addColorStop(0, "rgba(170,170,170,0.9)");
			my_gradient.addColorStop(0.5, "rgba(170,170,170,0.3)");
			my_gradient.addColorStop(1, "rgba(0,0,0,0)");
		}


		var tenPercentOfWidth = width / 10.0;
		var scale = width/75.0; // design size was 75px
		var insetRect3 = [x,y,width,height];
		insetRect3 = ABoo.VectorMath.inflateRect( insetRect3, -12.0*scale, -12.0*scale );

		// construct 3 inset rectangles
		var rect3PtArray = [[insetRect3[0],insetRect3[1]],[insetRect3[0]+insetRect3[2],insetRect3[1]],[insetRect3[0]+insetRect3[2], insetRect3[1]+insetRect3[3]], [insetRect3[0], insetRect3[1]+insetRect3[3]]];
		var rect2PtArray = ABoo.VectorMath.offsetPolygon( rect3PtArray, 5.0*scale );
		var rect1PtArray = ABoo.VectorMath.offsetPolygon( rect2PtArray, 5.0*scale );

		var insetRect2 = [ rect2PtArray[0][0], rect2PtArray[0][1], rect2PtArray[1][0]-rect2PtArray[0][0], rect2PtArray[2][1]-rect2PtArray[0][1] ];
		var insetRect1 = [ rect1PtArray[0][0], rect1PtArray[0][1], rect1PtArray[1][0]-rect1PtArray[0][0], rect1PtArray[2][1]-rect1PtArray[0][1] ];

		ctx.save();

			// outer
			var rects = ABoo.VectorMath.splitRectInTwo( insetRect3, 2.0*scale );
			ctx.fillStyle = my_gradient;
			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
				ctx.fill();
			ctx.restore();
			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
				ctx.fill();
			ctx.restore();

			// inner
			ctx.shadowColor = shadowCol;
			ctx.shadowBlur = 4;
			ctx.shadowOffsetX = 0;
			ctx.shadowOffsetY = tenPercentOfWidth/10;

			rects = ABoo.VectorMath.splitRectInTwo( insetRect2, 9.0*scale );
			ctx.fillStyle = innerCol;
			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
				ctx.fill();
			ctx.restore();

			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
				ctx.fill();
			ctx.restore();

			ctx.shadowColor= undefined;
			ctx.shadowBlur = undefined;

			// inner inner
			rects = ABoo.VectorMath.splitRectInTwo( insetRect1, 17.0*scale );
			ctx.fillStyle = innerinnerCol;
			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
				ctx.fill();
			ctx.restore();
			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
				ctx.fill();
			ctx.restore();

		ctx.restore();
	}
});


ABoo.ShiteDisplayLink = SC.Object.extend({

	_listeners: undefined,
	_canvasElements: undefined,
	_running: false,
	_timer: undefined,
	_time: 0,

	init: function( /* init never has args */ ) {
	    this._super();
		this._listeners = new Array();
		this._canvasElements = new Array();
		this._time = (new Date()).getTime();
	},

	registerListener: function( listener ) {
		this._listeners.push( listener );
		if(this._running==false && this._listeners.length>0 )
			this.start();
	},
	unregisterListener: function( listener ) {
		var i = this._listeners.indexOf(listener);
		if(i>-1)
			this._listeners.splice(i,1);
		if(this._running && this._canvasElements.length==0 && this._listeners.length==0 )
			this.stop();
	},

	registerCanvas: function( canvas ) {
		this._canvasElements.push( canvas );
		if(this._running==false && this._canvasElements.length>0 )
			this.start();
	},

	unregisterCanvas: function( canvas ) {
		console.warn("unregisterCanvas CANVAS!");
		var wasRunning = false;
		if( this._running ){
			this.stop();
			wasRunning = true;
		}

		var i = this._canvasElements.indexOf(canvas);
		if(i>-1) {
			this._canvasElements.splice(i,1);
			console.warn("removed canvas from array CANVAS!");
		}
		if( wasRunning && (this._canvasElements.length>0 || this._listeners.length>0) ) {
			console.warn("restarting DSIPLAY LINK because: was running? "+wasRunning +", "+this._canvasElements.length+" canvases, "+this._listeners.length+" listeners" );
			this.start();
		} else {
			console.warn("Not restarting DSIPLAY LINK because: "+wasRunning +" "+this._canvasElements.length+" "+this._listeners.length );
		}
	},

	start: function() {
		console.warn("STARTING DISPLAY LINK!");
		var self = this;
		this._timer = setInterval(function(){self._callback.call(self);}, 33);
		this._running = true;
	},
	stop: function() {
		console.warn("STOPPING DISPLAY LINK!");
        clearInterval(this._timer);
        this._timer = null;
		this._running = false;
	},

	_callback: function() {
		HOO_nameSpace.assert( this._canvasElements.length>0 || this._listeners.length>0, "why am i drawing with no listeners or canvases?");

		//console.log("ENTER TIMER::"+this._timer);
		this._time = (new Date()).getTime();
		var t = this._time;
		var listenersCopy = this._listeners.slice(0);
		$.each( listenersCopy, function(indexInArray, valueOfElement){
			valueOfElement.timeUpdate( t );
		});

		//this could mutate the array
		var canvasElementsCopy = this._canvasElements.slice(0);
		$.each( canvasElementsCopy, function(indexInArray, valueOfElement){
			valueOfElement.displayUpdate( t );
		});
		//console.log("EXIT TIMER::"+this._timer);
	}
});

var ShiteDisplayLinkClassMethods = {
	sharedDisplayLink: undefined
};
SC.mixin( ABoo.ShiteDisplayLink, ShiteDisplayLinkClassMethods );

ABoo.ShiteDisplayLink.sharedDisplayLink = ABoo.ShiteDisplayLink.create();


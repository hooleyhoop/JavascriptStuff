ABoo.SpeechBubbleBottom = SC.Object.extend({
});

ABoo.SpeechBubbleBottomClassMethods = {

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

SC.mixin( ABoo.SpeechBubbleBottom, ABoo.SpeechBubbleBottomClassMethods );

//
ABoo.Circle = ({});
ABoo.CircleClassMethods = {
	draw: function( ctx, rect ) {
		var rad = rect[2]/2;
		ctx.beginPath();
		ctx.arc( rect[0]+rad, rect[1]+rad, rad, 0, Math.PI*2, true);
		ctx.closePath();
	}
}
SC.mixin( ABoo.Circle, ABoo.CircleClassMethods );

//
ABoo.RoundedRectangle = SC.Object.extend({
});

// RoundedRectangle.mixin({
ABoo.RoundedRectangleClassMethods = {

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
SC.mixin( ABoo.RoundedRectangle, ABoo.RoundedRectangleClassMethods );

//
ABoo.RoundedTriangle = SC.Object.extend({
});
ABoo.RoundedTriangleClassMethods = {

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
SC.mixin( ABoo.RoundedTriangle, ABoo.RoundedTriangleClassMethods );

//
ABoo.Graphics = SC.Object.extend({
});

// Graphics.mixin({
ABoo.GraphicsClassMethods = {

	roundedTriangle: ABoo.RoundedTriangle,
	roundedRect: ABoo.RoundedRectangle,
	speechBubble_bottom: ABoo.SpeechBubbleBottom,
	circle: ABoo.Circle
};
SC.mixin( ABoo.Graphics, ABoo.GraphicsClassMethods );

//
ABoo.HooSprite = SC.Object.extend({

	setPropertiesOfSprite: function( propertyDict ) {
		for (var key in propertyDict) {
			var shouldBeValue = propertyDict[key];
			this.set(key,shouldBeValue);
		}
	}
});

//
ABoo.PlayButtonGraphic = SC.Object.extend({});
ABoo.PlayButtonGraphicClassMethods = {
	draw: function( ctx, x, y, width, height, isDsabled, isDown ) {

		ctx.save();
			var innerCol, innerinnerCol, shadowCol, my_gradient;

			if( isDsabled ) {
				innerCol = "#88a380";
				innerinnerCol = "#7d9876";
				shadowCol = null;
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(0, "rgba(230,230,230,1)");
				my_gradient.addColorStop(1, "rgba(230,230,230,0.5)");
			} else if( isDown ) {
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
				ABoo.Graphics["roundedTriangle"].draw( ctx, tri3Rect[0], tri3Rect[1], tri3Rect[2], tri3Rect[3], tenPercentOfWidth );
			ctx.fill();
			//ctx.strokeStyle = "#000";
			//	ABoo.Graphics["roundedTriangle"].draw( ctx, tri3Rect[0], tri3Rect[1], tri3Rect[2], tri3Rect[3], 0 );
			//ctx.stroke();

			ctx.shadowColor = shadowCol;
			ctx.shadowBlur = 4;
			ctx.shadowOffsetX = 0;
			ctx.shadowOffsetY = tenPercentOfWidth/10;

			ctx.fillStyle = innerCol;
				ABoo.Graphics["roundedTriangle"].draw( ctx, tri2Rect[0], tri2Rect[1], tri2Rect[2], tri2Rect[3], tenPercentOfWidth/2.0 );
			ctx.fill();
			//ctx.strokeStyle = "#000";
			//	ABoo.Graphics["roundedTriangle"].draw( ctx, tri2Rect[0], tri2Rect[1], tri2Rect[2], tri2Rect[3], 0 );
			//ctx.stroke();

			ctx.shadowColor= undefined;
			ctx.shadowBlur = undefined;

			ctx.fillStyle = innerinnerCol;
				ABoo.Graphics["roundedTriangle"].draw( ctx, tri1Rect[0], tri1Rect[1], tri1Rect[2], tri1Rect[3], 0 );
			ctx.fill();

		ctx.restore();
	}
}
SC.mixin( ABoo.PlayButtonGraphic, ABoo.PlayButtonGraphicClassMethods );

ABoo.PlayButtonSprite = ABoo.HooSprite.extend({
	_isDisabled: true,
	_isDown: false,
	spriteDraw: function( ctx, x, y, width, height ) {
		ABoo.PlayButtonGraphic.draw( ctx, x, y, width, height, this._isDisabled, this._isDown );
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

//
ABoo.RecordButtonGraphic = SC.Object.extend({});
ABoo.RecordButtonGraphicClassMethods = {
	draw: function( ctx, x, y, width, height, isDsabled, isDown ) {
		var graphicToDraw = "circle";
		ctx.save();
			var innerCol, innerinnerCol, shadowCol, my_gradient;

			if( isDsabled ) {
				innerCol = "#B55E70";
				innerinnerCol = "#BC494D";
				shadowCol = null;
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(0, "rgba(230,230,230,1)");
				my_gradient.addColorStop(1, "rgba(230,230,230,0.5)");
			} else if( isDsabled ) {
				innerCol = "#942E3E";
				innerinnerCol = "#BC242A";
				shadowCol = null;
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(1, "rgba(150,150,150,0.8)");
				my_gradient.addColorStop(0.5, "rgba(100,100,100,0.3)");
				my_gradient.addColorStop(0, "rgba(0,0,0,0.1)");
			} else {
				innerCol = "#F04F27";
				innerinnerCol = "#D3213C";
				shadowCol = "rgba(0,0,0,0.3)";
				my_gradient = ctx.createLinearGradient(0, 0, 0, height);
				my_gradient.addColorStop(0, "rgba(170,170,170,0.9)");
				my_gradient.addColorStop(0.5, "rgba(170,170,170,0.3)");
				my_gradient.addColorStop(1, "rgba(0,0,0,0)");
			}

			var tenPercentOfWidth = width / 10.0;
			var tri3Rect = [x,y,width,height];
			tri3Rect = ABoo.VectorMath.inflateRect( tri3Rect, -tenPercentOfWidth, -tenPercentOfWidth );
			var tri2Rect = ABoo.VectorMath.inflateRect( tri3Rect, -tenPercentOfWidth, -tenPercentOfWidth );
			var tri1Rect = ABoo.VectorMath.inflateRect( tri2Rect, -tenPercentOfWidth, -tenPercentOfWidth );

			ctx.fillStyle = my_gradient;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri3Rect );
			ctx.fill();

			ctx.shadowColor = shadowCol;
			ctx.shadowBlur = 4;
			ctx.shadowOffsetX = 0;
			ctx.shadowOffsetY = tenPercentOfWidth/10;

			ctx.fillStyle = innerCol;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri2Rect );
			ctx.fill();

			ctx.shadowColor= undefined;
			ctx.shadowBlur = undefined;

			ctx.fillStyle = innerinnerCol;
				ABoo.Graphics[graphicToDraw].draw( ctx, tri1Rect );
			ctx.fill();

		ctx.restore();
	}
}
SC.mixin( ABoo.RecordButtonGraphic, ABoo.RecordButtonGraphicClassMethods );

ABoo.RecordButtonSprite = ABoo.HooSprite.extend({
	_isDisabled: true,
	_isDown: false,

	spriteDraw: function( ctx, x, y, width, height ) {
		ABoo.RecordButtonGraphic.draw( ctx, x, y, width, height, this._isDisabled, this._isDown );

		var insetRect3 = [x,y,width,width];
		var scale = width/75.0; // design size was 75px
		insetRect3 = ABoo.VectorMath.inflateRect( insetRect3, -44.0*scale, -44.0*scale );
		var insetRect2 = ABoo.VectorMath.inflateRect( insetRect3, -12*scale, -12.0*scale );

		if( this._isDown ) {
			innerCol = "rgba(120,120,120,0.3)";
			innerinnerCol = "rgba(180,100,100,0.6)";
			shadowCol = null;
			//my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			//my_gradient.addColorStop(1, "rgba(150,150,150,0.8)");
			//my_gradient.addColorStop(0.5, "rgba(100,100,100,0.3)");
			//my_gradient.addColorStop(0, "rgba(0,0,0,0.1)");
		} else {
			innerCol = "rgba(255,255,255,0.5)";
			innerinnerCol = "rgba(255,235,235,0.9)";
			shadowCol = "rgba(0,0,0,0.1)";
			//my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			//my_gradient.addColorStop(0, "rgba(170,170,170,0.9)");
			//my_gradient.addColorStop(0.5, "rgba(170,170,170,0.3)");
			//my_gradient.addColorStop(1, "rgba(0,0,0,0)");
		}


		ctx.fillStyle = innerCol;
		ctx.save();
			ABoo.Graphics["circle"].draw( ctx, insetRect3 );
			ctx.fill();
		ctx.restore();

		ctx.fillStyle = innerinnerCol;
		ctx.save();
			ABoo.Graphics["circle"].draw( ctx, insetRect2 );
			ctx.fill();
		ctx.restore();
	}
});

// TODO! Put the pause button in the record circle
ABoo.PauseRecordingButtonSprite = ABoo.HooSprite.extend({
	_isDown: false,

	spriteDraw: function( ctx, x, y, width, height ) {

		// NB!
		ABoo.RecordButtonGraphic.draw( ctx, x, y, width, height, this._isDisabled, this._isDown );

		var graphicToDraw = "roundedRect";
		var innerCol, innerinnerCol, shadowCol, my_gradient;

		if( this._isDown ) {
			innerCol = "rgba(120,120,120,0.3)";
			innerinnerCol = "rgba(180,100,100,0.6)";
			shadowCol = null;
			//my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			//my_gradient.addColorStop(1, "rgba(150,150,150,0.8)");
			//my_gradient.addColorStop(0.5, "rgba(100,100,100,0.3)");
			//my_gradient.addColorStop(0, "rgba(0,0,0,0.1)");
		} else {
			innerCol = "rgba(255,255,255,0.5)";
			innerinnerCol = "rgba(255,235,235,0.9)";
			shadowCol = "rgba(0,0,0,0.1)";
			//my_gradient = ctx.createLinearGradient(0, 0, 0, height);
			//my_gradient.addColorStop(0, "rgba(170,170,170,0.9)");
			//my_gradient.addColorStop(0.5, "rgba(170,170,170,0.3)");
			//my_gradient.addColorStop(1, "rgba(0,0,0,0)");
		}


		var tenPercentOfWidth = width / 10.0;
		var insetRect3 = [x,y,width,width];
		var scale = width/75.0; // design size was 75px
		insetRect3 = ABoo.VectorMath.inflateRect( insetRect3, -44.0*scale, -44.0*scale );
		var tri2Rect = ABoo.VectorMath.inflateRect( insetRect3, -12.0*scale, -12.0*scale );
		var tri1Rect = ABoo.VectorMath.inflateRect( tri2Rect, -12.0*scale, -12.0*scale );

		//tri3Rect = ABoo.VectorMath.inflateRect( tri3Rect, -tenPercentOfWidth, -tenPercentOfWidth );
		//var tri2Rect = ABoo.VectorMath.inflateRect( tri3Rect, -tenPercentOfWidth, -tenPercentOfWidth );
		//var tri1Rect = ABoo.VectorMath.inflateRect( tri2Rect, -tenPercentOfWidth, -tenPercentOfWidth );

		// construct 3 inset rectangles
		var rect3PtArray = [[insetRect3[0],insetRect3[1]],[insetRect3[0]+insetRect3[2],insetRect3[1]],[insetRect3[0]+insetRect3[2], insetRect3[1]+insetRect3[3]], [insetRect3[0], insetRect3[1]+insetRect3[3]]];
		var rect2PtArray = ABoo.VectorMath.offsetPolygon( rect3PtArray, 5.0*scale );
		var rect1PtArray = ABoo.VectorMath.offsetPolygon( rect2PtArray, 5.0*scale );

		var insetRect2 = [ rect2PtArray[0][0], rect2PtArray[0][1], rect2PtArray[1][0]-rect2PtArray[0][0], rect2PtArray[2][1]-rect2PtArray[0][1] ];
		var insetRect1 = [ rect1PtArray[0][0], rect1PtArray[0][1], rect1PtArray[1][0]-rect1PtArray[0][0], rect1PtArray[2][1]-rect1PtArray[0][1] ];

		ctx.save();

			// outer
			var rects = ABoo.VectorMath.splitRectInTwo( insetRect3, 2.0*scale );
			ctx.fillStyle = innerCol;
			ctx.save();
				//	ctx.rect( insetRect1[0], insetRect1[1], insetRect1[2], insetRect1[3]);
				//ABoo.Graphics["circle"].draw( ctx, insetRect3 );
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
				ctx.fill();
			ctx.restore();

			ctx.save();
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
				ctx.fill();
			ctx.restore();

			// inner
			ctx.shadowColor = shadowCol;
			ctx.shadowBlur = 2;
			ctx.shadowOffsetX = 0;
			ctx.shadowOffsetY = tenPercentOfWidth/10;

			rects = ABoo.VectorMath.splitRectInTwo( insetRect2, 9.0*scale );
			ctx.fillStyle = innerinnerCol;
			ctx.save();
				//ABoo.Graphics["circle"].draw( ctx, tri2Rect );
				ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
				ctx.fill();
			ctx.restore();

			ctx.save();
			//	ABoo.Graphics["circle"].draw( ctx, tri1Rect );

				ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
				ctx.fill();
			ctx.restore();

			ctx.shadowColor= undefined;
			ctx.shadowBlur = undefined;

			// inner inner
			//rects = ABoo.VectorMath.splitRectInTwo( insetRect1, 17.0*scale );
			//ctx.fillStyle = innerinnerCol;
			//ctx.save();
			//	ABoo.Graphics[graphicToDraw].draw( ctx, rects[0][0], rects[0][1], rects[0][2], rects[0][3], rects[0][2]/2.0 );
			//	ctx.fill();
			//ctx.restore();
			//ctx.save();
			//	ABoo.Graphics[graphicToDraw].draw( ctx, rects[1][0], rects[1][1], rects[1][2], rects[1][3], rects[1][2]/2.0 );
			//	ctx.fill();
			//ctx.restore();

		ctx.restore();
	}
});


// TODO! What is the difference between a sprote and a graphic?
ABoo.DonutTestSprite = ABoo.HooSprite.extend({

	_loadColor:"rgba(170,170,170,0.8)",
	_playColor:"#0080C7",
	_busyColor:"#22b248",

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

			// THis actually happens quite often > basically happerns when you have started playing but...
			//HOO_nameSpace.assert( loadingRotAmount>=playingRotAmount, "Go on, explain to me how this happened.");

			var outerRadius = width/2.0 * outerRad;
			var innerRadius = width/2.0 * innerRad;

			var centrePt = [width/2.0, height/2.0];
			var startAngle = -Math.PI/2.0;
			var busySpinnerWidth = Math.PI/6.0;
			var playingEndAngle = startAngle+playingRotAmount;
			var busyStartAngle = busySpinnerAngle-busySpinnerWidth/2.0;
			var busyEndAngle = busySpinnerAngle+busySpinnerWidth/2.0;

			ctx.globalCompositeOperation = 'source-over';

			// Man, i am a fool for not working out the winding rule stuff!!!
			// Man, i am a fool for not working out the winding rule stuff!!!
			// Man, i am a fool for not working out the winding rule stuff!!!
			// Man, i am a fool for not working out the winding rule stuff!!!
			// Man, i am a fool for not working out the winding rule stuff!!!

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

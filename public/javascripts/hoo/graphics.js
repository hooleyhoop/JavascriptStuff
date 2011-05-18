RoundedTriangle = SC.Object.extend({
});
RoundedTriangle.mixin({
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
});

Graphics = SC.Object.extend({
});
Graphics.mixin({
	roundedTriangle: RoundedTriangle
});

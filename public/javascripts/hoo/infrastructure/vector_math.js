ABoo.VectorMath = SC.Object.extend({
});

var VectorMathClassMethods = {

	trianglePtArrayFromRect: function( rectArray ) {
		var pt1 = [rectArray[0],rectArray[1]];
		var pt2 = [rectArray[0]+rectArray[2], rectArray[1]+rectArray[3]/2.0];
		var pt3 = [rectArray[0],rectArray[1]+rectArray[3]];
		var ptArray = [pt1, pt2, pt3];
		return ptArray;
	},

	inflateRect: function( rect, p, q ) {
		var newRect = [rect[0]-p/2.0, rect[1]-q/2.0, rect[2]+p, rect[3]+q];
		return newRect;
	},

	offsetRect: function( rect, p ) {
		var newRect = [rect[0]+p[0], rect[1]+p[1], rect[2], rect[3]];
		return newRect;
	},

	ptNormalize: function( pt ) {
		var l = this.ptLength(pt);
		//if the current point is (0,5), and you normalize it to 1, the point returned is at (0,1).
		var newPt = [pt[0]/l, pt[1]/l];
		return newPt;
	},

	ptAdd: function( pt1, pt2 ) {
		var newPt = [pt1[0]+pt2[0], pt1[1]+pt2[1]];
		return newPt;
	},

	ptLength: function( pt ) {
		var l = Math.sqrt(pt[0]*pt[0]+pt[1]*pt[1]);
		return l;
	},

	// find the angle between incoming line and outgoing line and offset the point along that line
	offsetPolygon: function( pts, offset ) {

		var offsetPts = new Array();

		for( var i=0; i<pts.length; i++ ) {
			// wrap the indexes
			var preIndex = i-1;
			if(preIndex==-1) preIndex = pts.length-1;
			var postIndex = i+1;
			if( postIndex==pts.length ) postIndex = 0;

			var p1 = this.vectorBetweenPts( pts[preIndex], pts[i], pts[postIndex], offset );
			var pt1 = [ p1[0], p1[1] ];
			offsetPts.push(pt1);
		}
		return offsetPts;
	},

	vectorBetweenPts: function( pt1, pt2, pt3, newLength ) {

		var p1 = [ pt1[0]-pt2[0], pt1[1]-pt2[1] ];
		var p3 = [ pt3[0]-pt2[0], pt3[1]-pt2[1] ];
		p1 = this.ptNormalize( p1 );
		p3 = this.ptNormalize( p3 );
		var midWayVector = this.ptAdd(p1,p3);
		midWayVector = this.ptNormalize( midWayVector );
		var scaledMidwayPt =  [midWayVector[0]*newLength+pt2[0], midWayVector[1]*newLength+pt2[1] ];
		return scaledMidwayPt;
	},

	splitRectInTwo: function( rect, margin ) {

		var x = rect[0];
		var rightEdge = x + rect[2];
		var midx = x + rect[2]/2.0;

		var midLeftSide = midx - margin/2.0;
		var leftSideWidth = midLeftSide - x;

		var midRightSide = midx + margin/2.0;
		var rightSideWidth = rect[2] - (midRightSide-x);

		var newR1 = [ x, rect[1], leftSideWidth, rect[3] ];
		var newR2 = [ midRightSide, rect[1], rightSideWidth, rect[3] ];
		var newRects  = [newR1, newR2];
		return newRects;
	}
};
SC.mixin( ABoo.VectorMath, VectorMathClassMethods );


ABoo.HooMath = SC.Object.extend({
});

var HooMathClassMethods = {

	lerp: function (x0,y0,x1,y1,x) {
		//console.log("Lerping "+x0+" "+y0+" "+x1+" "+y1+" "+x+" ");
		y = y0*((x - x1)/(x0 - x1)) + y1*((x - x0)/(x1 - x0));

		// check that the lerp value is actually in the required range
		//dist = y0-y1;
		//if(dist>1)
		//	if(y<y0 || y>y1)
		//		debugger;
		//else
		//	if(y>y0 || y<y1)
		//		debugger;
		return y;
	},

	xAsUnitPercentOfY: function( x, y ) {
		if(y===0)
			y = 1.0;
		var unitPercent = x/y;
		return ABoo.HooMath._clipToUnitValue(unitPercent);
	},

	// more for debugging pirposes than anything
	_clipToUnitValue: function( val ) {
		if(val<-1 || val>1.1)
			//debugger;
			consol.warn("seems like a fishy value to clip.."+val);
		else if (val<0)
			val = 0;
		else if(val>1)
			val = 1;
		return val;
	}
}
SC.mixin( ABoo.HooMath, HooMathClassMethods );


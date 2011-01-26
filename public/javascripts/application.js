function fuckYeah( stringArg1 ) {
	alert( stringArg1 );
}

/*
 * Sob sob sob
 * I don't like this being here. This is really an integral part of textListView and is not intended to be used elsewhere
 * Oh, i don't know how to lay this stuff out
*/
function crippleListView( listID, targetFunctionName ) {

	var listSelector = listID + " > li";
	var $list = $( listSelector );
	$.each( $list, function(index, value) {

		var $each = $(value);			// alert($each.text());

		// select a in $value - obvious!
		var $anchor = $('a', $each);
		var currentLink = $anchor.attr( "href" );

		// remove the link from the anchor
		$anchor.attr( "href", "#" );

		// and add our jQuery event instead
		$anchor.mousedown( function( ) {

			// call function from string 'targetFunctionName'
			var fn = window[targetFunctionName];
			if(typeof fn === 'function') {
				fn( currentLink );
			}

		});
	});
}

/*
 * look for data-jsclass, create an instance for each
 */
function createJSObjectsFromRubyObjects() {

	// -- get all objects with data-jsClass attribute 'steve'
	var all_jsClass_objects = $(":customdata(jsclass)" );
	$.each( all_jsClass_objects, function( i, ob ) {
		var idString = $(ob).attr('id');
		var className = $(ob).customdata('jsclass');
		var newInstanceName = '_'+idString;
		var hmm = eval(className);
		var newInstance = hmm.create( {id: idString} );
		if( window[newInstanceName]!=undefined )
			console.error("Cannot create instance of "+className );
		window[newInstanceName] = newInstance;
		console.log( "Created "+newInstanceName );
	});
}







/*
 * MyClassA
*/
MyClassA = SC.Object.extend({

	foo: "foo1",

	init: function() {
		arguments.callee.base.apply(this,arguments);
		console.log("inited!");
	},

	bar: function() {
		return "bar";
	},

	myMethod: function() {
		console.log('myMethod1');
	}
});

MyClassA.prototype.foo = "foo1"


/*
 * MyClassB
*/
MyClassB = MyClassA.extend({

	myMethod: function() {
		arguments.callee.base.apply(this,arguments);
		console.log("myMethod2");
	}
});


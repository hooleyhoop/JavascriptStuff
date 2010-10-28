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


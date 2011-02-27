/* S E T   U P */

/*
 * look for data-jsclass in the page, create an instance for each
 * ** TODO ** !: $.live() can bind an event handler to not just all objects that exist now but all objects in the future as well.
 * somehow we can use this to create new instances on ajax-ed html, no?
 */

 // 1) Object is inserted into page
 // 2) bind somehow spots it, runs an event - probably not possible! whenever we load html by ajax we must check to see if it needs this running
 // 3) the inserted object has some javascript to run - it's instance is created.
 //	4) the element has a custom action, in the json
function createJSObjectsFromRubyObjects( rootElement ) {

	var all_jsClass_objects;
	if(rootElement==undefined) {
		// -- get all objects with data-jsClass attribute ''
		all_jsClass_objects = $(":customdata(jsclass)" );
	} else {
		all_jsClass_objects = rootElement.find(":customdata(jsclass)");
	}

	$.each( all_jsClass_objects, function( i, ob )
	{
		var idString = $(ob).attr('id');
		var className = $(ob).customdata('jsclass');
		var newInstanceName = '_'+idString;
		var jsonName = newInstanceName+'_json';
		var jsonOb =  window[jsonName];
		if( jsonOb==undefined )
			console.error("cannot find json for "+className );

		var hmm = eval(className);
		var newInstance = hmm.create( {id: idString, json: jsonOb} );

		if( window[newInstanceName]!=undefined )
			console.error("That instance already exists! Cannot create instance of "+className );

		window[newInstanceName] = newInstance;
		console.log( "Created "+newInstanceName );
	});
}


/* W I D G E T S */

/*
 * This is the prototype class for an instance that should be automatically created on
 * page load because it was tagged with a jsclass attribute server side.
 * set these values in Create( hash )
*/
HooWidget = SC.Object.extend({
	json: "undefined",
	id: "undefined",
});

/* Flippy Debug thing */

Flippy_toggle_thing = HooWidget.extend({

	flippyFlip: function() {
		var queryString = "#"+this.id;
		var $thisHTML = $( queryString );
		if( $thisHTML.length!=1 )
			console.error("Could not find the thisHTML");
		$thisHTML.css( "background-color", "#000" );

	},
});

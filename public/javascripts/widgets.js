/* S E T   U P */

/*
 * look for data-jsclass in the page, create an instance for each
 */
function createJSObjectsFromRubyObjects() {

	// -- get all objects with data-jsClass attribute ''
	var all_jsClass_objects = $(":customdata(jsclass)" );
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
			console.error("Cannot create instance of "+className );

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

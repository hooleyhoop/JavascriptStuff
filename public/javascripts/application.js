function formatTime(time) {
	var minutes = Math.floor(time/60);
	var seconds = Math.floor(time)%60;
	return minutes + ':' + (seconds<10 ? '0'+seconds : seconds);
}

function fuckYeah( stringArg1 ) {
	alert( stringArg1 );
}

/* O L D   S T U F F */

/*
 * Sob sob sob
 * This is a startup script for the widget list on the single_widget page
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



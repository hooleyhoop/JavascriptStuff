function fuckYeah( stringArg1 ) {
	alert( stringArg1 );
}

function crippleListView( stringArg1 ) {

	var $list = $( "#widgetSelect > li" );
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
			var fn = window[ '#{_.target.actionName}' ];
			if(typeof fn === 'function') {
				fn( currentLink );
			}

		});
	});
}


/* Flippy Debug thing */

Flippy_toggle_thing = HooWidget.extend({

	_flippyState: undefined,

	init: function( /* no args! */ ) {
	    this._super();
		this._flippyState = false;
	},

	setupDidComplete: function() {

		this.div$; // TODO swap this
		debugger;
		var queryString = "#"+this.id;
		var $thisHTML = $( queryString );
		var self = this;
		$thisHTML.bind('click', function(e) {self.flippyFlip();});
	},

	flippyFlip: function() {

		// it is crucial that you set the property in a KVO complient manner
		this.set( '_flippyState', !this._flippyState );
		this.updateGraphics();
	},

	// where possible try to extract non testable stuff from logic
	updateGraphics: function() {

		var queryString = "#"+this.id;
		var $thisHTML = $( queryString );
		if( $thisHTML.length==1 )
		{
			if(this._flippyState)
				$thisHTML.css( "background-color", "#000" );
			else
				$thisHTML.css( "background-color", "#ff0000" );
		} else {
			console.log("Could not find the thisHTML");
		}
	}


});

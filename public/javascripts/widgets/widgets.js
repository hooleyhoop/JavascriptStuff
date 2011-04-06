/* S E T   U P */

// use http://jshint.com/

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

	// create the global window instance
	var $win = $('hooWindow');
	_hooWindow = HooWindow.create( {id: 'hooWindow'} );

	var all_jsClass_objects;
	if(rootElement===undefined) {
		// -- get all objects with data-jsClass attribute ''
		all_jsClass_objects = $(":customdata(jsclass)" );
	} else {
		all_jsClass_objects = rootElement.find(":customdata(jsclass)");
	}

	// var anExperiment = $win.find(":nth-child(0)");
		// $("div span:nth-child(1)")

	$.each( all_jsClass_objects, function( i, ob )
	{
		var idString = $(ob).attr('id');
		if(idString==="") {
			alert("cunt data class without id");
		}
		var className = $(ob).customdata('jsclass');
		var newInstanceName = '_'+idString;
		var jsonName = newInstanceName+'_json';
		var jsonOb =  window[jsonName];
		if( jsonOb===undefined )
			console.info("cannot find json for "+className );

		var hmm = eval(className);
		var newInstance = hmm.create( {id: idString, json: jsonOb} );

		if( window[newInstanceName]!==undefined ) {
			console.error("That instance already exists! Cannot create instance of "+className );
		}
		window[newInstanceName] = newInstance;

		// maybe should add to content view
		_hooWindow.addSubView( newInstance );

		console.log( "Created "+newInstance +" > "+ newInstanceName );
	});

	_hooWindow.setupDidComplete();
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

	// forward events to 'this'
	// i think we have a problem here, eventTrampoline is not called as an instance method (ie. 'this' is not what we think it is so dont assume you can use instance variables)
	eventTrampoline: function(e,a) {

		var target = e.data.target;
		var action = e.data.action;
		var arg = e.data.arg;
		// target[action](arg, e);
		target[action].call(target,arg, e);
	},

	parentDidResize: function() {
	},

	// extract bindings from json - move to widget
	setup_hoo_binding: function( binding ) {

		if( this.json.bindings && this.json.bindings[binding] ){
			var b = this.json.bindings[binding];
			var target = window[ b['to_taget'] ];
			if(target===undefined)
				debugger;
			var initialState = target.get( b['to_property'] );
			this.readyDidChange( target, b['to_property'] );
			target.addObserver( b['to_property'], this, this[ b['do_action'] ] );
			return true;
		}
		return false;
	},

	// extract actions from json - move to widget
	setup_hoo_action: function( action ) {

		if( this.json.javascriptActions && this.json.javascriptActions[action] )
		{
			var a = this.json.javascriptActions[action];
			var target	= window[ a['action_taget'] ];
			var action	= target[ a['action_event'] ];
			var arg		= a['action_arg'];
			return { t:target, a:action, w:arg };
		}
		return null;
	},

	// given an instance variable that contains the name of an object, swap the content of the instance variable for the actual object
	swapFindAndSwapInstanceVariableNamed: function( iVarName ) {

		var jsonProp = this.json[iVarName];
		var value = null;
		if( window[jsonProp] ) {
			value = window[jsonProp];
		}
		this.set( iVarName, value );
	}

});

HooWindow = HooWidget.extend({

	_allViews: undefined, // maybe should go into content view? Just an unordered array of every view at the mo
	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);
		this._allViews = new Array();
		$(window).bind( 'resize', {target:this, action:'windowDidResize', arg:"" }, this.eventTrampoline );
	},
	windowDidResize: function() {
		$(this._allViews).each( function(i,ob){
			if(ob.parentDidResize) {
				ob.parentDidResize();
			} else
				debugger;
		});
	},
	addSubView: function( childView ) {
		this._allViews.push( childView );
	},

	/* all the child views were created */
	setupDidComplete: function() {
		$(this._allViews).each( function(i,ob){
			if(ob.setupDidComplete!==undefined)
				ob.setupDidComplete();
		});
	}
});

// not using at the mo.. think might be useful tho
HooContentView = HooWidget.extend({
	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);
	}
});

/* Flippy Debug thing */

Flippy_toggle_thing = HooWidget.extend({

	flippyFlip: function() {
		var queryString = "#"+this.id;
		var $thisHTML = $( queryString );
		if( $thisHTML.length!=1 )
			console.error("Could not find the thisHTML");
		$thisHTML.css( "background-color", "#000" );

	}
});

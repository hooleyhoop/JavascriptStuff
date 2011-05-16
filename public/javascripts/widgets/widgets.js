/* S E T   U P */

// use http://jshint.com/

/*
 * look for data-jsclass in the page, create an instance for each
 * ** TODO ** !: $.live() can bind an event handler to not just all objects that exist now but all objects in the future as well.
 * somehow we can use this to create new instances on ajax-ed html, no?
 */
HOO_nameSpace = SC;


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
		all_jsClass_objects = $('[data-jsclass]');
	} else {
		all_jsClass_objects = rootElement.find('[data-jsclass]');
	}

	// var anExperiment = $win.find(":nth-child(0)");
		// $("div span:nth-child(1)")

	$.each( all_jsClass_objects, function( i, ob )
	{
		var idString = $(ob).attr('id');
		if(idString==="") {
			alert("cunt data class without id");
		}
		var className = $(ob).data('jsclass');

		var newInstanceName = '_'+idString;
		var jsonName = newInstanceName+'_json';
		var jsonOb = window[jsonName];
		if( jsonOb===undefined )
			console.info("cannot find json for "+className );

		var hmm = eval(className);
		var newInstance = hmm.create( {id: idString, json: jsonOb} );

		if( HOO_nameSpace[newInstanceName]!==undefined ) {
			console.error("That instance already exists! Cannot create instance of "+className );
		}
		HOO_nameSpace[newInstanceName] = newInstance;

		// maybe should add to content view
		_hooWindow.addSubView( newInstance );

		console.log( "Created "+newInstance +" > "+ newInstanceName );
	});

	_hooWindow.setupDidComplete();
}


// forward events to 'this'
function eventTrampoline(e,a) {
	var target = e.data.target;
	var action = e.data.action;
	var arg = e.data.arg;

	if( typeof action === "string" )
		target[action].call(target,arg, e);
	else if( $.isFunction(action) )
		action.call(target,arg, e);
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

	parentDidResize: function() {
	},

	// extract bindings from json
	setup_hoo_binding_from_json: function( bindingName ) {
		if( this.json.bindings && this.json.bindings[bindingName] ){
			var bindingConfig = this.json.bindings[bindingName];
			this.bindToKeypath( bindingConfig['to_taget'], bindingConfig['to_property'], bindingConfig['do_action'] );
			return true;
		}
		return false;
	},

	teardown_hoo_binding_from_json: function( bindingName ) {
		if( this.json.bindings && this.json.bindings[bindingName] ){
			var bindingConfig = this.json.bindings[bindingName];
			this.unbindToKeypath( bindingConfig['to_taget'], bindingConfig['to_property'], bindingConfig['do_action'] );
		}
	},

	bindToKeypath: function( targetName, propertyName, observerDidChangeMethod ) {
		var target = HOO_nameSpace[targetName];
		if(target===undefined)
			debugger;
		this.bindToTarget( target, propertyName, this, observerDidChangeMethod );
	},

	unbindToKeypath: function( targetName, propertyName, observerDidChangeMethod ) {
		var target = HOO_nameSpace[targetName];
		this.unbindToTarget( target, propertyName, this, observerDidChangeMethod );
	},

	bindToTarget: function( target, propertyName, observer, observerDidChangeMethod ) {
		target.addObserver( propertyName, observer, observerDidChangeMethod );
		observer[observerDidChangeMethod].call( observer, target, propertyName ); // sync initial value
	},

	unbindToTarget: function( target, propertyName, observer, observerDidChangeMethod ) {
		target.removeObserver( propertyName, observer, observerDidChangeMethod );
	},

	setup_hoo_action_from_json: function( action ) {

		if( this.json.javascriptActions && this.json.javascriptActions[action] )
		{
			var a = this.json.javascriptActions[action];
			var target	= HOO_nameSpace[ a['action_taget'] ];
			var action	= target[ a['action_event'] ];
			var arg		= a['action_arg'];
			var isAsync = a['actionIsAsync'];
			return { t:target, a:action, w:arg, actionIsAsync: isAsync };
		}
		return null;
	},

	// given an instance variable that contains the name of an object, swap the content of the instance variable for the actual object
	swapFindAndSwapInstanceVariableNamed: function( iVarName ) {

		var jsonProp = this.json[iVarName];
		var value = null;
		if( HOO_nameSpace[jsonProp] ) {
			value = HOO_nameSpace[jsonProp];
		}
		this.set( iVarName, value );
	}

});

HooWindow = HooWidget.extend({

	_allViews: undefined, // maybe should go into content view? Just an unordered array of every view at the mo
	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);
		this._allViews = new Array();
		$(window).bind( 'resize', {target:this, action:'windowDidResize', arg:"" }, eventTrampoline );
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


HooWindow.hooAlert = function( arg ) {
	alert(arg);
};
HooWindow.hooLog = function( arg ) {
	console.log(arg);
};
// not using at the mo.. think might be useful tho
HooContentView = HooWidget.extend({
	init: function( /* init never has args */ ) {
		arguments.callee.base.apply(this,arguments);
	}
});

HOO_nameSpace.HooWindow = HooWindow;
HOO_nameSpace.HooContentView = HooContentView;


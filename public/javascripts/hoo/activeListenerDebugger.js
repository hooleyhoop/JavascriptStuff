ActiveListenerDebugger = SC.Object.extend({

	_targets:undefined,

	init: function( /*  */ ) {
		arguments.callee.base.apply( this, arguments );
		this._targets = new Object;
	},

	addListener: function( target, event, actionMethod ) {

		if( this.alreadyContain( target, event, actionMethod ) )
			throw( "Doh, adding listener twice" );
		target.bind( event, {arg1:null, arg2:'null'}, actionMethod );
		this.storeEventListen( target, event, actionMethod );
	},

	removeListener: function( target, event, actionMethod ) {

		var registeredHandlers = this._targets[target];
		if(registeredHandlers==null) {
			console.warn("Trying to remove a listener that isnt registered "+event );
			return;
		}
		var indexToRemove=-1;

		$.each( registeredHandlers, function(index, element) {
			if( element['type']==event && element['listener']==actionMethod ) {
				indexToRemove = index;
				return false;
			}
		});

		if(indexToRemove>-1) {
			registeredHandlers.splice(indexToRemove,1);
			this._targets[target] = registeredHandlers;
		}
		target.unbind( event, actionMethod );
	},

	alreadyContain: function( target, event, actionMethod ) {

		var registeredHandlers = this._targets[target];
		if(registeredHandlers==null)
			return false;

		var result = false;
		$.each( registeredHandlers, function(index, element) {
			if( element['type']==event && element['listener']==actionMethod ) {
				result = true;
				return false;
			}
		});
		return result;
	},

	storeEventListen: function( target, event, actionMethod ) {

		var eventDetails = { type:event, listener:actionMethod };
		var currentListenersForTarget = this._targets[target];
		if(currentListenersForTarget==null)
			currentListenersForTarget = new Array();
		currentListenersForTarget.push( eventDetails );
		this._targets[target] = currentListenersForTarget;
	}
});


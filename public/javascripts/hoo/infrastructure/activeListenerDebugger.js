ABoo.ActiveListenerDebugger = SC.Object.extend({

	_targets:undefined,

	init: function( /*  */ ) {
	    this._super();
		this._targets = new Object;
	},

	addListener: function( item, event, targetOb, actionMethod ) {

        if( item==null || targetOb==null || event==null || actionMethod==null || item==null || targetOb==undefined || event==undefined || actionMethod==undefined ) {
			//throw("NO! - cant add listener to Null");
			debugger;
		}
		if( this.alreadyContain( item, event, targetOb, actionMethod ) ) {
			// throw( "Doh, adding listener twice" );
			debugger;
		}
		item.bind( event, {target:targetOb, action:actionMethod, arg:null }, eventTrampoline );
		this.storeEventListen( item, event, targetOb, actionMethod );
	},

	removeListener: function( item, event, targetOb, actionMethod ) {

        if( item==null || targetOb==null || event==null || actionMethod==null || item==null || targetOb==undefined || event==undefined || actionMethod==undefined )
			debugger;

		var registeredHandlers = this._targets[item];
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
			this._targets[item] = registeredHandlers;
		}
		item.unbind( event, eventTrampoline );
	},

	alreadyContain: function( item, event, targetOb, actionMethod ) {

		var registeredHandlers = this._targets[item];
		if(registeredHandlers==null)
			return false;

		var result = false;
		$.each( registeredHandlers, function(index, element) {
			if( element['type']==event && element['target']==targetOb && element['listener']==actionMethod ) {
				result = true;
				return false;
			}
		});
		return result;
	},

	storeEventListen: function( item, event, targetOb, actionMethod ) {

		var eventDetails = { type:event, target:targetOb , listener:actionMethod };
		var currentListenersForTarget = this._targets[item];
		if(currentListenersForTarget==null)
			currentListenersForTarget = new Array();
		currentListenersForTarget.push( eventDetails );
		this._targets[item] = currentListenersForTarget;
	}
});


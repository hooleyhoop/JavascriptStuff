# It has to be a mixin, to mix it in, no?
ABoo.RootObject = SC.Mixin.create
	json: undefined
	id: undefined
	div$: undefined
	init: () ->
		@[SC.GUID_KEY] = @id if @id? 	# by assigning this[SC.GUID_KEY] to the divs-id it becomes a valid sproutcore view
		@id=@[SC.GUID_KEY] if !@id? 
		
		this.div$ or= $( "#"+@id )
		this.div$.addClass("sc-view")
		@_super()
		
	parentDidResize: ->
		return 0

	getFirstDomItemOfType: (type) ->
		$item = @div$.find(type+":first");
		if( $item.length!=1 )
			debugger;
			console.error("Could not find the "+type+" dom item")
			return null
		return $item
			
	# given an instance variable that contains the name of an object, swap the content of the instance variable for the actual object
	swapFindAndSwapInstanceVariableNamed: ( jsonProp, iVarName ) ->
		value = null
		if( HOO_nameSpace[jsonProp] )
			value = HOO_nameSpace[jsonProp];
		else
			debugger;
		@set( iVarName, value )


# TODO: finish moving bindings from widget
ABoo.Bindings = SC.Mixin.create

	bindToTarget: ( target, propertyName, observer, observerDidChangeMethod ) ->
		target.addObserver( propertyName, observer, observerDidChangeMethod )
		observer[observerDidChangeMethod].call( observer, target, propertyName ) #sync initial value

	unbindToTarget: ( target, propertyName, observer, observerDidChangeMethod ) ->
		target.removeObserver( propertyName, observer, observerDidChangeMethod )
		
	#TODO: more stuff to move where from widget
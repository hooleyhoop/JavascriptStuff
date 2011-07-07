###
	HTML
###
ABoo.DomNodeProxy = SC.Object.extend
	_swfID: undefined
	_commandableSwf:undefined
	_observableSwf: undefined
	_delegate: undefined
	_ready: undefined
	_tag: undefined

	init: () ->
		@_super()
		@_swfID = ABoo.FlashObject.newID()
		@_observableSwf = document.createElement(@_tag)
		@_commandableSwf = @_observableSwf		
		@_ready = false

	# Hack in some utility functions to make sure audio element has the same interface as the swf
	getNodeProperty: (propertyName) ->
		return @_commandableSwf[propertyName]

	setNodeProperty: (propertyName,value) -> 
		@_commandableSwf[propertyName]=value

	attrGetter: (propertyName) ->
		this.getNodeProperty(propertyName)

	attrSetter: (propertyName,value) ->
		@_commandableSwf.setAttribute(propertyName,value)

	cmd: (functionName, argArray ) ->
		@_commandableSwf[functionName].apply(@_commandableSwf,argArray)

	appendToDiv: ( div$ ) ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@_observableSwf.appendTo( div$ )
		@flashDidLoad();

	flashDidLoad: () ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@_ready = true
		@_delegate.flashDidLoad( this )

	remove: () ->
		@_observableSwf.remove()
		@_ready = false

	setSwfSize: ( width, height ) ->
		@_observableSwf.width( width )
		@_observableSwf.height( height )

	matchSwfSizeToItem: () ->
		@setSwfSize( @_currentPlaceHolder.width(), @_currentPlaceHolder.height() )		

###
	DomNodeProxyClassMethods
###
ABoo.DomNodeProxyClassMethods = SC.Mixin.create
	newDomNodeProxyFortag: ( tag ) ->
		return this.create( {_tag:tag} )

SC.mixin( ABoo.DomNodeProxy, ABoo.DomNodeProxyClassMethods )
						


###
	SharedDomNodeProxy
###
ABoo.SharedDomNodeProxy = ABoo.DomNodeProxy.extend
	_currentPlaceHolder: undefined
	_activeScriptItem: undefined
	
	swapInForItem: ( scriptItem, domItem$ ) ->
		if @_currentPlaceHolder?
			@_observableSwf.after( @_currentPlaceHolder ) 	# put back previous swapped out item
			@remove()										# remove the swf from page

		@_currentPlaceHolder = domItem$
		@setActiveScriptItem( scriptItem )		
		@insertSwfVisibly()
		@flashDidLoad();
		
	replacePlaceHolderWithSwf: () ->
		@_currentPlaceHolder.after( @_observableSwf )
		@_currentPlaceHolder.remove()
			
	insertSwfVisibly: () ->
		@matchSwfSizeToItem()
		@replacePlaceHolderWithSwf()
			
	setActiveScriptItem: ( item ) ->
		if @_activeScriptItem? then @_activeScriptItem.didSwapOutFlash( this )
		@_activeScriptItem = item
		@_delegate = @_activeScriptItem 
		@_activeScriptItem.didSwapInFlash( this )

###
	SharedDomNodeProxyClassMethods
###						
ABoo.SharedDomNodeProxyClassMethods = SC.Mixin.create ABoo.DomNodeProxyClassMethods,
	_cached: new Object()

	sharedDivForTag: ( tag ) ->
		cachedFlash = @_cached[tag];
		if !cachedFlash?
			cachedFlash = @create( {_tag:tag} )
			@_cached[tag] = cachedFlash
		return cachedFlash

SC.mixin( ABoo.SharedDomNodeProxy, ABoo.SharedDomNodeProxyClassMethods )

###
	HeadlessSharedDomNodeProxy
###
ABoo.HeadlessSharedDomNodeProxy = ABoo.SharedDomNodeProxy.extend

	appendToDiv: ( div$ ) ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@flashDidLoad();

	swapInForItem: ( scriptItem, domItem$ ) ->
		if @_currentPlaceHolder?
			@remove()
		
		@_currentPlaceHolder = domItem$
		@setActiveScriptItem( scriptItem )
		@insertSwfInvisibly()
		@flashDidLoad()

	remove: () ->
		@_ready = false
			
	insertSwfInvisibly: () ->
		0

SC.mixin( ABoo.HeadlessSharedDomNodeProxy, ABoo.SharedDomNodeProxyClassMethods )

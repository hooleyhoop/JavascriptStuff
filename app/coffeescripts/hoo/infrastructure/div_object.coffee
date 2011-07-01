###
	HTML
###
ABoo.DivObject = SC.Object.extend

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
		@_commandableSwf.getNodeProperty = (propertyName) ->
			return this[propertyName]();
			
		# @_commandableSwf.setNodeProperty = (propertyName,value) -> 
		#	this['set'+propertyName](value)
		
	###
		!important: everytime you move the swf it creates a new instance
	###
	appendToDiv: ( div$ ) ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@_observableSwf.appendTo( div$ )
		@flashDidLoad();
			
	remove: () ->
		@_observableSwf.remove()
		@_ready = false

	#addReadyBindingAndTimeOut: () ->
	#	@_observableSwf.bind 'ready', () =>
	#		@flashDidLoad();
	#	@_readyTimeout = SC.run.later( this, "readyDidTimeout", 1000 )

	# only does anything for headless swf
	# TODO: something weird here..flashDidLoad is still called here, but for headless player we have to rebind. Why?
	#readyDidTimeout: () ->
	#	$('body').trigger('event_flashBlockedDetected');
	#	@_blocked = YES		
	#	@_readyTimeout = null
	#	return 0
		
	flashDidLoad: () ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@_ready = true
		@_delegate.flashDidLoad( this )

	setSwfSize: ( width, height ) ->
		@_observableSwf.width( width )
		@_observableSwf.height( height )
		#@_observableSwf.attr( "width", @_currentPlaceHolder.width()*3 )
		#@_observableSwf.attr( "height", @_currentPlaceHolder.height()*3 )

	matchSwfSizeToItem: () ->
		@setSwfSize( @_currentPlaceHolder.width(), @_currentPlaceHolder.height() )
			
ABoo.DivObjectClassMethods = SC.Mixin.create
	newDivFortag: ( tag ) ->
		return ABoo.DivObject.create( {_tag:tag} )
	

###
	Shared Div
###
ABoo.SharedDivObject = ABoo.DivObject.extend
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
						
ABoo.SharedDivObjectClassMethods = SC.Mixin.create ABoo.DivObjectClassMethods,
	_cached: new Object()

	sharedDivForTag: ( tag ) ->
		cachedFlash = @_cached[tag];
		if !cachedFlash?
			cachedFlash = @create( {_tag:tag} )
			@_cached[tag] = cachedFlash
		return cachedFlash


###
	Shared Headless Flash
###
ABoo.HeadlessSharedDivObject = ABoo.SharedDivObject.extend

	swapInForItem: ( scriptItem, domItem$ ) ->
		if @_currentPlaceHolder?
			@remove()
		
		@_currentPlaceHolder = domItem$
		@setActiveScriptItem( scriptItem )
		@insertSwfInvisibly()
		@flashDidLoad()
			
	insertSwfInvisibly: () ->
		# TODO: not needed for audio - will be needed for others
		#@setSwfSize( 1, 1 )
		#$('body').after( @_observableSwf )
		
	# only does anything for headless swf
	#readyDidTimeout: () ->
	#	$('body').trigger('event_flashBlockedDetected');
	#	@_blocked = YES
	#	@_readyTimeout = null		
	#	@remove()	# remove the swf
	#	@insertSwfVisibly()
	#	
	#	# TODO: something weird here..flashDidLoad is still called for basic, but for headless player we have to rebind to 'ready' event. Why?
	#	@_observableSwf.bind 'ready', () =>
	#		@flashBlockerDidFuckOff();
	
	# christ, this whole idea is broken.
	# Once we have put the flash-blocked headless player visibly into the page so the use can click it (to tell the flash blocker to load it)
	# You can't then make it invisible again (moving it restarts the whole blocking process)
	#flashBlockerDidFuckOff: () ->
	#	@setSwfSize( 0, 0 )
	#	@_observableSwf.after( @_currentPlaceHolder ) 	# put back previous swapped out item
	#	@_blocked = NO
	#	@flashDidLoad()

ABoo.HeadlessSharedDivObjectClassMethods = SC.Mixin.create ABoo.SharedDivObjectClassMethods,
	# ok, this is copied and spasted for now as unsure how to do ABoo.HeadlessSharedFlashObject.create instead of ABoo.SharedFlashObject.create
	sharedDivForTag: ( tag ) ->
		cachedFlash = @_cached[tag];
		if !cachedFlash?
			cachedFlash = @create( {_tag:tag} )
			@_cached[tag] = cachedFlash
		return cachedFlash

SC.mixin( ABoo.DivObject, ABoo.DivObjectClassMethods )
SC.mixin( ABoo.SharedDivObject, ABoo.SharedDivObjectClassMethods )
SC.mixin( ABoo.HeadlessSharedDivObject, ABoo.HeadlessSharedDivObjectClassMethods )

###
	Flash
###
ABoo.FlashObject = SC.Object.extend
	_url: undefined
	_width: undefined
	_height: undefined
	_flashVarDict: undefined
	_objectTagString: undefined
	_swfID: undefined
	_commandableSwf:undefined
	_observableSwf: undefined
	_delegate: undefined
	_ready: undefined
	_readyTimeout: undefined
	_currentPlaceHolder: undefined
	_blocked: NO
	
	init: () -> # _url, _width, _height, _flashVarDict
		@_super()
		@_width or= "100%"
		@_height or= "100%"
		@_flashVarDict or= new Object()
		@_swfID = ABoo.FlashObject.newID()
		@_objectTagString = ABoo.FlashObject.embedString( @_url, @_swfID, @_width, @_height, @_flashVarDict )
		$wrapper = $("<div class='swfHolder'/>")
		
		if($.browser.msie)
			$wrapper[0].innerHTML = @_objectTagString;
		else
			$wrapper.append(@_objectTagString);
		@_observableSwf = $wrapper;
		@_commandableSwf = $wrapper.find('object')[0]
		
		@_ready = false
		
		# Hack in some utility functions to make sure audio element has the same interface as the swf
		#@_commandableSwf.getNodeProperty = function(propertyName){ return this[propertyName](); };
		#@_commandableSwf.setNodeProperty = (propertyName,value) -> 
		#	this['set'+propertyName](value)
		
	###
		!important: everytime you move the swf it creates a new instance
	###
	appendToDiv: ( div$ ) ->
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		this.addReadyBindingAndTimeOut()
		@_observableSwf.appendTo( div$ )
			
	remove: () ->
		if @_readyTimeout? then SC.run.cancel( @_readyTimeout )
		@_observableSwf.remove()
		@_ready = false

	addReadyBindingAndTimeOut: () ->
		@_observableSwf.bind 'ready', () =>
			@flashDidLoad();
		@_readyTimeout = SC.run.later( this, "readyDidTimeout", 1000 )

	# only does anything for headless swf
	# TODO: something weird here..flashDidLoad is still called here, but for headless player we have to rebind. Why?
	readyDidTimeout: () ->
		$('body').trigger('event_flashBlockedDetected');
		@_blocked = YES		
		@_readyTimeout = null
		return 0
		
	flashDidLoad: () ->
		#alert("wha");
		HOO_nameSpace.assert( @_ready==false, "ready called twice?" )
		@_ready = true
		SC.run.cancel( @_readyTimeout )
		@_readyTimeout = null
		@_blocked = NO
		@_delegate.flashDidLoad( this )

	setSwfSize: ( width, height ) ->
		@_observableSwf.width( width )
		@_observableSwf.height( height )
		#@_observableSwf.attr( "width", @_currentPlaceHolder.width()*3 )
		#@_observableSwf.attr( "height", @_currentPlaceHolder.height()*3 )

	matchSwfSizeToItem: () ->
		@setSwfSize( @_currentPlaceHolder.width(), @_currentPlaceHolder.height() )


ABoo.FlashObjectClassMethods = SC.Mixin.create
	_id: 0
	newID: () ->
		return @_id++
	
	uRLForSwf: ( swfName ) ->
		return "/flash/#{swfName}.swf"

	newSwfForURL: ( swfURL, width, height, flashVarDict ) ->
		return ABoo.FlashObject.create( {_url:swfURL, _width:width, _height:height, _flashVarDict:flashVarDict} )

	cachedSwfForURL:() ->
		return nil;
		
	embedString: ( url, idNum, width, height, flashVarDict ) ->
		# var attemptSillyCacheFoil = YES;
		# var foilString = attemptSillyCacheFoil ? "?"+encodeURIComponent(new Date().toUTCString()) : "";
		# append foilstring to swf url to defeat cache?
		flashVarDict['rootID'] = idNum
		flashVars = @flashVarString(flashVarDict)
		"<object data='#{url}' id='#{idNum}' type='application/x-shockwave-flash' width=#{width} height=#{height}><param name='movie' value='#{url}'/><param name='allowScriptAccess' value='always'/><param name='FlashVars' value='#{flashVars}'/></object>"
	
	# This is slightly fucked as the hash isn't ordered
	flashVarString: ( dict ) ->
		flashVarString = ""
		for key, val of dict
			newString = "#{key}=#{val}"
			flashVarString = if flashVarString.length>0 then "#{flashVarString}&#{newString}" else newString
		return flashVarString
	

###
	Shared Flash
###
ABoo.SharedFlashObject = ABoo.FlashObject.extend
	_currentPlaceHolder: undefined
	_activeScriptItem: undefined
	
	swapInForItem: ( scriptItem, domItem$ ) ->
		if @_currentPlaceHolder?
			@_observableSwf.after( @_currentPlaceHolder ) 	# put back previous swapped out item
			@remove()										# remove the swf from page

		this.addReadyBindingAndTimeOut()
		@_currentPlaceHolder = domItem$
		@setActiveScriptItem( scriptItem )		
		@insertSwfVisibly()

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
						
ABoo.SharedFlashObjectClassMethods = SC.Mixin.create ABoo.FlashObjectClassMethods,
	_cached: new Object()

	sharedSwfForURL: ( swfURL, width, height, flashVarDict ) ->
		cachedFlash = @_cached[swfURL];
		if !cachedFlash?
			cachedFlash = @create( {_url:swfURL, _width:width, _height:height, _flashVarDict:flashVarDict} )
			@_cached[swfURL] = cachedFlash
		return cachedFlash


###
	Shared Headless Flash
###
ABoo.HeadlessSharedFlashObject = ABoo.SharedFlashObject.extend

	swapInForItem: ( scriptItem, domItem$ ) ->
		if @_currentPlaceHolder?
			if @_blocked
				@_observableSwf.after( @_currentPlaceHolder ) 	# put back previous swapped out item
			@remove()
		
		@_currentPlaceHolder = domItem$
		@setActiveScriptItem( scriptItem )

		if @_blocked
			@readyDidTimeout()	# cheekily just skip ahead to the timeout bit, we know already that it is blocked
			
		else
			@addReadyBindingAndTimeOut()
			@insertSwfInvisibly()
		
	insertSwfInvisibly: () ->
		@setSwfSize( 1, 1 )
		$('body').after( @_observableSwf )
		
	# only does anything for headless swf
	readyDidTimeout: () ->
		$('body').trigger('event_flashBlockedDetected');
		@_blocked = YES
		@_readyTimeout = null		
		@remove()	# remove the swf
		@insertSwfVisibly()
		
		# TODO: something weird here..flashDidLoad is still called for basic, but for headless player we have to rebind to 'ready' event. Why?
		@_observableSwf.bind 'ready', () =>
			@flashBlockerDidFuckOff();
	
	# christ, this whole idea is broken.
	# Once we have put the flash-blocked headless player visibly into the page so the use can click it (to tell the flash blocker to load it)
	# You can't then make it invisible again (moving it restarts the whole blocking process)
	flashBlockerDidFuckOff: () ->
		@setSwfSize( 0, 0 )
		@_observableSwf.after( @_currentPlaceHolder ) 	# put back previous swapped out item
		@_blocked = NO
		@flashDidLoad()

ABoo.HeadlessSharedFlashObjectClassMethods = SC.Mixin.create ABoo.SharedFlashObjectClassMethods,
	# ok, this is copied and spasted for now as unsure how to do ABoo.HeadlessSharedFlashObject.create instead of ABoo.SharedFlashObject.create
	sharedSwfForURL: ( swfURL, width, height, flashVarDict ) ->
		cachedFlash = @_cached[swfURL];
		if !cachedFlash?
			cachedFlash = @create( {_url:swfURL, _width:"100%", _height:"100%", _flashVarDict:flashVarDict} )
			@_cached[swfURL] = cachedFlash
		return cachedFlash

SC.mixin( ABoo.FlashObject, ABoo.FlashObjectClassMethods )
SC.mixin( ABoo.SharedFlashObject, ABoo.SharedFlashObjectClassMethods )
SC.mixin( ABoo.HeadlessSharedFlashObject, ABoo.HeadlessSharedFlashObjectClassMethods )			
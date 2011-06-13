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
		
		# Hack in some utility functions to make sure audio element has the same interface as the swf
		#@_commandableSwf.getNodeProperty = function(propertyName){ return this[propertyName](); };
		#@_commandableSwf.setNodeProperty = function(propertyName,value){ this['set'+propertyName](value); };
		
		# when we cache, do we check size? FlashVars? dum dum dum dum
		# ABoo.FlashObject._cached[@_url] = @
		
	###
		!important: everytime you move the swf it creates a new instance?
	###
	appendToDiv: ( div$ ) -> 
		$wrapper.bind 'ready', () =>
			@flashDidLoad();

		@_observableSwf.appendTo( div$ )

!! V E R Y M U C H N E E D T O T E S T T H I S !!
	flashDidLoad: () ->
		alert("ooh ya bugger")
		
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
	
	swapInForItem: ( item$ ) ->
		if @_currentPlaceHolder?
			@_observableSwf.after( @_currentPlaceHolder )
			@_observableSwf.remove()
			
		@_observableSwf.bind 'ready', () =>
			@flashDidLoad();
	
		item$.after( @_observableSwf )
		item$.remove()
		@_currentPlaceHolder = item$


ABoo.SharedFlashObjectClassMethods = SC.Mixin.create ABoo.FlashObjectClassMethods,
	_cached: new Object()
	sharedSwfForURL: ( swfURL, width, height, flashVarDict ) ->
		
		cachedFlash = @_cached[swfURL];
		if !cachedFlash?
			cachedFlash = ABoo.SharedFlashObject.create( {_url:swfURL, _width:width, _height:height, _flashVarDict:flashVarDict} )
			@_cached[swfURL] = cachedFlash
		return cachedFlash
			
SC.mixin( ABoo.FlashObject, ABoo.FlashObjectClassMethods )
SC.mixin( ABoo.SharedFlashObject, ABoo.SharedFlashObjectClassMethods )

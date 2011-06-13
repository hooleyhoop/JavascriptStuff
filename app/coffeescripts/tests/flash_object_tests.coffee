module( "Flash Object", {
  	setup: () ->
})

test( "url for flash", () ->
	result = ABoo.FlashObject.uRLForSwf("ImgResizer/ImgResizer")
	equals( result, "/flash/ImgResizer/ImgResizer.swf", "!" )
)

test( "flash var string", () ->
	testDict =
		url: "hello_world"
		autostart: true
		autoplay: false
		rootID: 562

	result = ABoo.FlashObject.flashVarString( testDict )
	# This is slightly fucked as the hash isnt really ordered
	equals( result, "url=hello_world&autostart=true&autoplay=false&rootID=562", "!" )
)

test( "embed string", () ->
	flashVarDict =
		play: false
	result = ABoo.FlashObject.embedString( "/made/up", 69, 50, 60, flashVarDict )
	equals( result, "<object data='/made/up' id='69' type='application/x-shockwave-flash' width=50 height=60><param name='movie' value='/made/up'/><param name='allowScriptAccess' value='always'/><param name='FlashVars' value='play=false&rootID=69'/></object>", "!" )
)

test( "new unique id", () ->
	equals( ABoo.FlashObject.newID(), 0, "!" )
	equals( ABoo.FlashObject.newID(), 1, "!" )
	equals( ABoo.FlashObject.newID(), 2, "!" )
)

test( "new flash object", () ->
	flashURL = ABoo.FlashObject.uRLForSwf("ImgResizer/ImgResizer")
	imgURL = "http://farm2.static.flickr.com/1013/887300612_044d2e38ed.jpg"
	
	equals( ABoo.SharedFlashObject.newID(), 0, "!" )
	
	flashOb3 = ABoo.SharedFlashObject.sharedSwfForURL( flashURL, "100%", "100%", {imgURL:imgURL} );
	
	flashOb1 = ABoo.FlashObject.newSwfForURL( flashURL, "100%", "100%", {imgURL:imgURL} )
	flashOb2 = ABoo.FlashObject.newSwfForURL( flashURL, "100%", "100%", {imgURL:imgURL} )
	
	flashOb4 = ABoo.SharedFlashObject.sharedSwfForURL( flashURL, "100%", "100%", {imgURL:imgURL} );
	
	equals( flashOb1 != flashOb2, true, "!" )
	equals( flashOb1._swfID != flashOb2._swfID, true, "!" )
	
	equals( flashOb3 == flashOb4, true, "!" )
	equals( flashOb3._swfID == flashOb4._swfID, true, "!" )	
	
)



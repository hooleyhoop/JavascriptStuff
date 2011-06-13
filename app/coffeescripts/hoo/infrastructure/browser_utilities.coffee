ABoo.browserCanPlayNativeMP3 = ()  ->
	canPlayMP3 = false
	audioElem = document.createElement('audio') # we have to create an audio element to sniff capabilities
	if audioElem.canPlayType?
		# Chrome for some reason thinks it can't play audio/mpeg, so check for mp3 as well
		canPlayMpegString = audioElem.canPlayType('audio/mpeg;')
		canPlayMP3String = audioElem.canPlayType('audio/mp3;')
		if canPlayMpegString=="maybe" || canPlayMpegString=="probably" || canPlayMP3String=="maybe" || canPlayMP3String=="probably"
			canPlayMP3 = true
	return canPlayMP3

# as far as audioPlayback is concerned
ABoo.browserIsSafari = () ->
	# Safari 5 on SL has unreliable MP3 playback
	if /safari/i.test(navigator.userAgent)
		# Chrome and android have safari in their user agent string, so let's discount them
		# chrome will play webm, safari wont
		audioElem = document.createElement('audio') # we have to create an audio element to sniff capabilities
		if !audioElem.canPlayType('audio/webm;')
			return true;
	return false

ABoo.browserSupportsCanvas = () ->
	# if( Modernizr.canvas!==undefined || we are a browser supported by excanvas.js )
	return true

ABoo.whichPlayerVersion = () ->
	attrs = 
		canvas: ABoo.browserSupportsCanvas()
		html5Audio: ABoo.browserCanPlayNativeMP3()
		isSafari: ABoo.browserIsSafari()
		flash: hasMinimumFlash()
	return ABoo.whichPlayerVersion( attrs );
	
ABoo.whichPlayerVersion = ( attrs ) ->
	if attrs.canvas and attrs.html5Audio
		return "html5AudioPLayer"
	else
		if !attrs.flash
			return "linkAudioPLayer"
		else if attrs.canvas
			return "headlessAudioPLayer"
	return "flashAudioPLayer"


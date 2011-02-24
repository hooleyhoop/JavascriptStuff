function browserCanPlayNativeMP3() {

	var canPlayMP3 = false;
	var audioElem = document.createElement('audio'); // we have to create an audio element to sniff capabilities
	if( audioElem.canPlayType!=undefined ) {
		//Chrome for some reason thinks it can't play audio/mpeg, so check for mp3 as well
		var canPlayMpegString = audioElem.canPlayType('audio/mpeg;');
		var canPlayMP3String = audioElem.canPlayType('audio/mp3;');
		if( canPlayMpegString=="maybe" || canPlayMpegString=="probably" || canPlayMP3String=="maybe" || canPlayMP3String=="probably" )
			canPlayMP3 = true;
	}
	return canPlayMP3;
}

// as far as audioPlayback is concerned
function browserIsSafari() {
	// Safari 5 on SL has unreliable MP3 playback
	if( /safari/i.test(navigator.userAgent) ) {
		// Chrome and android have safari in their user agent string, so let's discount them
		// chrome will play webm, safari wont
		var audioElem = document.createElement('audio'); // we have to create an audio element to sniff capabilities
		if( !audioElem.canPlayType('audio/webm;') )
			return true;
	}
	return false;
}

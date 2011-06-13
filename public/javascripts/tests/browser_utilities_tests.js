module( "Browser Utilities", {
  setup: function() {}
});

test("browserCanPlayNativeMP3", function() {
	equals( ABoo.browserCanPlayNativeMP3(), true, "!" );
});

test("browserIsSafari", function() {
	equals( ABoo.browserIsSafari(), true, "!" );
});

test("browserSupportsCanvas", function() {
	equals( ABoo.browserSupportsCanvas(), true, "!" );
});

test("which player version?", function() {

	var atts1 = { canvas:YES, html5Audio:YES, isSafari:YES, flash:NO };
	var res1 = ABoo.whichPlayerVersion( atts1 );
	equals( res1, "html5AudioPLayer", "!" );

	var atts2 = { canvas:YES, html5Audio:YES, isSafari:YES, flash:YES };
	var res2 = ABoo.whichPlayerVersion( atts2 );
	equals( res2, "html5AudioPLayer", "!" );

	var atts3 = { canvas:YES, html5Audio:NO, isSafari:YES, flash:YES };
	var res3 = ABoo.whichPlayerVersion( atts3 );
	equals( res3, "headlessAudioPLayer", "!" );

	var atts4 = { canvas:NO, html5Audio:NO, isSafari:YES, flash:YES };
	var res4 = ABoo.whichPlayerVersion( atts4 );
	equals( res4, "flashAudioPLayer", "!" );

	var atts5 = { canvas:NO, html5Audio:NO, isSafari:YES, flash:NO };
	var res5 = ABoo.whichPlayerVersion( atts5 );
	equals( res5, "linkAudioPLayer", "!" );
});

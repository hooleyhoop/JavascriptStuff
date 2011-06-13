/* DO NOT MODIFY. This file was compiled Mon, 13 Jun 2011 15:31:53 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/tests/flash_object_tests.coffee
 */

(function() {
  module("Flash Object", {
    setup: function() {}
  });
  test("url for flash", function() {
    var result;
    result = ABoo.FlashObject.uRLForSwf("ImgResizer/ImgResizer");
    return equals(result, "/flash/ImgResizer/ImgResizer.swf", "!");
  });
  test("flash var string", function() {
    var result, testDict;
    testDict = {
      url: "hello_world",
      autostart: true,
      autoplay: false,
      rootID: 562
    };
    result = ABoo.FlashObject.flashVarString(testDict);
    return equals(result, "url=hello_world&autostart=true&autoplay=false&rootID=562", "!");
  });
  test("embed string", function() {
    var flashVarDict, result;
    flashVarDict = {
      play: false
    };
    result = ABoo.FlashObject.embedString("/made/up", 69, 50, 60, flashVarDict);
    return equals(result, "<object data='/made/up' id='69' type='application/x-shockwave-flash' width=50 height=60><param name='movie' value='/made/up'/><param name='allowScriptAccess' value='always'/><param name='FlashVars' value='play=false&rootID=69'/></object>", "!");
  });
  test("new unique id", function() {
    equals(ABoo.FlashObject.newID(), 0, "!");
    equals(ABoo.FlashObject.newID(), 1, "!");
    return equals(ABoo.FlashObject.newID(), 2, "!");
  });
  test("new flash object", function() {
    var flashOb1, flashOb2, flashOb3, flashOb4, flashURL, imgURL;
    flashURL = ABoo.FlashObject.uRLForSwf("ImgResizer/ImgResizer");
    imgURL = "http://farm2.static.flickr.com/1013/887300612_044d2e38ed.jpg";
    equals(ABoo.SharedFlashObject.newID(), 0, "!");
    flashOb3 = ABoo.SharedFlashObject.sharedSwfForURL(flashURL, "100%", "100%", {
      imgURL: imgURL
    });
    flashOb1 = ABoo.FlashObject.newSwfForURL(flashURL, "100%", "100%", {
      imgURL: imgURL
    });
    flashOb2 = ABoo.FlashObject.newSwfForURL(flashURL, "100%", "100%", {
      imgURL: imgURL
    });
    flashOb4 = ABoo.SharedFlashObject.sharedSwfForURL(flashURL, "100%", "100%", {
      imgURL: imgURL
    });
    equals(flashOb1 !== flashOb2, true, "!");
    equals(flashOb1._swfID !== flashOb2._swfID, true, "!");
    equals(flashOb3 === flashOb4, true, "!");
    return equals(flashOb3._swfID === flashOb4._swfID, true, "!");
  });
}).call(this);

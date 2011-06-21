/* DO NOT MODIFY. This file was compiled Tue, 21 Jun 2011 10:14:21 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/browser_utilities.coffee
 */

(function() {
  ABoo.browserCanPlayNativeMP3 = function() {
    var audioElem, canPlayMP3, canPlayMP3String, canPlayMpegString;
    canPlayMP3 = false;
    audioElem = document.createElement('audio');
    if (audioElem.canPlayType != null) {
      canPlayMpegString = audioElem.canPlayType('audio/mpeg;');
      canPlayMP3String = audioElem.canPlayType('audio/mp3;');
      if (canPlayMpegString === "maybe" || canPlayMpegString === "probably" || canPlayMP3String === "maybe" || canPlayMP3String === "probably") {
        canPlayMP3 = true;
      }
    }
    return canPlayMP3;
  };
  ABoo.browserIsSafari = function() {
    var audioElem;
    if (/safari/i.test(navigator.userAgent)) {
      audioElem = document.createElement('audio');
      if (!audioElem.canPlayType('audio/webm;')) {
        return true;
      }
    }
    return false;
  };
  ABoo.browserSupportsCanvas = function() {
    return true;
  };
  ABoo.whichPlayerVersion = function() {
    var attrs;
    attrs = {
      canvas: ABoo.browserSupportsCanvas(),
      html5Audio: ABoo.browserCanPlayNativeMP3(),
      isSafari: ABoo.browserIsSafari(),
      flash: hasMinimumFlash()
    };
    return ABoo.whichPlayerVersion(attrs);
  };
  ABoo.whichPlayerVersion = function(attrs) {
    if (attrs.isSafari && attrs.canvas && attrs.flash) {
      return "headlessAudioPLayer";
    }
    if (attrs.canvas && attrs.html5Audio) {
      return "html5AudioPLayer";
    } else {
      if (!attrs.flash) {
        return "linkAudioPLayer";
      } else if (attrs.canvas) {
        return "headlessAudioPLayer";
      }
    }
    return "flashAudioPLayer";
  };
}).call(this);

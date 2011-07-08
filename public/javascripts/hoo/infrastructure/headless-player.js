/* DO NOT MODIFY. This file was compiled Thu, 07 Jul 2011 11:37:20 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/headless-player.coffee
 */

(function() {
  /* abstract superclass for flash and html5
  */  ABoo.NewHeadlessPlayerSingleton = SC.Object.extend({
    _audioPlayingDomNode: void 0,
    _mp3url: void 0,
    setSrc: function(mp3Url2, autoload, autoplay) {
      if (!(mp3Url2 != null)) {
        debugger;
      }
      if (this._mp3url !== mp3Url2) {
        this._mp3url = mp3Url2;
        console.log("SRC: " + mp3Url2);
        if (autoplay === true) {
          this._audioPlayingDomNode.attrSetter('autoplay', 'autoplay');
          autoload = true;
        }
        this._audioPlayingDomNode.attrSetter('src', mp3Url2);
        if (autoload === true) {
          this._audioPlayingDomNode.cmd('load');
        }
      }
      return 0;
    },
    playerBecameCurrent: function(playerInstance, $pageItem) {
      this._audioPlayingDomNode.swapInForItem(playerInstance, $pageItem);
      return 0;
    },
    _getTimeRangeEnd: function(timeRanges, timeRangeIndex) {
      debugger;      return 0;
    },
    buffered: function() {
      var endTime, timeRangeIndex, timeRanges;
      endTime = 0;
      timeRanges = this._audioPlayingDomNode.getNodeProperty('buffered');
      if (!(timeRanges != null)) {
        console.log("Buffered attribute NOT found");
        return 0;
      }
      if (timeRanges.length > 0) {
        try {
          timeRangeIndex = timeRanges.length - 1;
          endTime = this._getTimeRangeEnd(timeRanges, timeRangeIndex);
        } catch (error) {
          alert(error);
          return 0;
        }
      }
      return endTime;
    },
    duration: function() {
      var dur;
      dur = this._audioPlayingDomNode.getNodeProperty('duration');
      if (isNaN(dur)) {
        dur = 0;
      }
      return dur;
    },
    loadedDegrees: function() {
      var buffered, duration, loadedDegrees;
      buffered = this.buffered();
      duration = this.duration();
      loadedDegrees = duration === 0 ? 0 : buffered / duration * 360;
      return loadedDegrees;
    },
    playedDegrees: function() {
      var ct, duration, playedDegrees;
      ct = this._audioPlayingDomNode.attrGetter('currentTime');
      duration = this.duration();
      playedDegrees = duration === 0 ? 0 : ct / duration * 360;
      console.log("<<<<< playedDegrees: " + ct + " " + duration + " >>>>>> " + playedDegrees);
      return playedDegrees;
    },
    play: function() {
      return this._audioPlayingDomNode.cmd('play');
    },
    pause: function() {
      return this._audioPlayingDomNode.cmd('pause');
    },
    setCurrentTime: function(secs) {
      return this._audioPlayingDomNode.attrSetter('currentTime', secs);
    }
  });
}).call(this);

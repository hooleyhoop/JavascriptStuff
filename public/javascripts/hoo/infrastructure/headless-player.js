/* DO NOT MODIFY. This file was compiled Tue, 12 Jul 2011 13:59:44 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/headless-player.coffee
 */

(function() {
  /* abstract superclass for flash and html5
  */  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.NewHeadlessPlayerSingleton = SC.Object.extend({
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
  SC.mixin(ABoo.NewHeadlessPlayerSingleton, ABoo.SingletonClassMethods);
  /* one of these for each instance of a player
  */
  ABoo.NewHeadlessPlayer = SC.Object.extend({
    _mp3URL: void 0,
    _controller: void 0,
    _watchableEvents: 'error emptied loadstart progress loadeddata loadedmetadata durationchange timeupdate canplay canplaythrough waiting play ended abort dataunavailable empty pause ratechange seeked seeking volumechange stalled',
    _stateMachine: void 0,
    _state: false,
    _headLessSingleton: void 0,
    _attachToPage: function($pageItem) {
      this._createSingletonPlayer();
      this._stateMachine = ABoo.AudioPlayerStateMachine.create({
        _controller: this._controller
      });
      return this._headLessSingleton.playerBecameCurrent(this, $pageItem);
    },
    didSwapInFlash: function(swf) {
      return this._state = true;
    },
    didSwapOutFlash: function(swf) {
      this._state = false;
      this._killObservations();
      return this._controller.hidePlayerGUI();
    },
    flashDidLoad: function(swf) {
      this._controller.showPlayerGUI();
      this._createObservervations();
      this._stateMachine.processInputSignal("ready");
      return this._headLessSingleton.setSrc(this._mp3URL, true, true);
    },
    _createObservervations: function() {
      var $actualPlayer;
      $actualPlayer = $(this._headLessSingleton._audioPlayingDomNode._observableSwf);
      return $actualPlayer.bind(this._watchableEvents, __bind(function(e) {
        return this.handleHeadlessFlashPlayerEvent(e.type);
      }, this));
    },
    _killObservations: function() {
      var $actualPlayer;
      $actualPlayer = $(this._headLessSingleton._audioPlayingDomNode._observableSwf);
      return $actualPlayer.unbind(this._watchableEvents);
    },
    handleHeadlessFlashPlayerEvent: function(eventName) {
      return this._stateMachine.processInputSignal(eventName);
    },
    buffered: function() {
      return this._headLessSingleton.buffered();
    },
    loadedDegrees: function() {
      return this._headLessSingleton.loadedDegrees();
    },
    playedDegrees: function() {
      return this._headLessSingleton.playedDegrees();
    },
    play: function() {
      return this._headLessSingleton.play();
    },
    pause: function() {
      return this._headLessSingleton.pause();
    },
    setCurrentTime: function(secs) {
      return this._headLessSingleton.setCurrentTime(secs);
    }
  });
}).call(this);

/* DO NOT MODIFY. This file was compiled Wed, 13 Jul 2011 14:06:22 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/headless-player.coffee
 */

(function() {
  /* abstract superclass for flash and html5
  */  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.NewAbstractHeadlessPlayerSingleton = SC.Object.extend({
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
  SC.mixin(ABoo.NewAbstractHeadlessPlayerSingleton, ABoo.SingletonClassMethods);
  /* one of these for each instance of a player
  */
  ABoo.NewAbstractHeadlessPlayerBackend = SC.Object.extend({
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
  /* one of these for each instance of a player
  */
  ABoo.NewAbstractSmallPlayer = ABoo.SCView.extend({
    _playerBackend: void 0,
    _hooCanvas: void 0,
    _placeHolder$: void 0,
    _smallPlayerFrontEnd: void 0,
    _ready: false,
    _loadProgress: 0,
    _playProgress: 0,
    _busyFlag: false,
    mouseUp: function(ev$) {
      if (this._playerBackend._state === false) {
        if (this._placeHolder$) {
          return this._playerBackend._attachToPage(this._placeHolder$);
        }
      }
    },
    showPlayerGUI: function() {
      var playPause, radialProgress, thePlayButtonJson, theRadialProgressJson;
      SC.RunLoop.begin();
      this._hooCanvas = ABoo.HooCanvas.newProgrammaticCanvas();
      this._hooCanvas.swapInFor(this._placeHolder$);
      this._hooCanvas._setSize(this._placeHolder$.width(), this._placeHolder$.height());
      thePlayButtonJson = {
        "percentOfCanvas": 0.7,
        "javascriptActions": {
          "mouseClickAction": {
            "action_taget": this,
            "action_event": ["playClickAction", "pauseClickAction"],
            "action_arg": null,
            "actionIsAsync": true
          }
        }
      };
      theRadialProgressJson = {
        "outerRad": 0.95,
        "innerRad": 0.85
      };
      radialProgress = ABoo.HooRadialProgress.create({
        json: theRadialProgressJson,
        _hooCanvas: this._hooCanvas
      });
      playPause = ABoo.HooPlayPauseButton.create({
        json: thePlayButtonJson,
        _hooCanvas: this._hooCanvas
      });
      console.warn("created radial " + radialProgress + " and play " + playPause);
      this._smallPlayerFrontEnd = ABoo.SmallPlayerPlayButton.create({
        _radialProgress: radialProgress,
        _playPauseButton: playPause
      });
      this.addObserver('_loadProgress', radialProgress, radialProgress.loadDidChange);
      this.addObserver('_playProgress', radialProgress, radialProgress.playDidChange);
      this.addObserver('_busyFlag', radialProgress, radialProgress.busyDidChange);
      this.addObserver('_ready', playPause, 'enabledDidChange');
      radialProgress.setupDidComplete();
      playPause.setupDidComplete();
      this._smallPlayerFrontEnd.setupDidComplete();
      return SC.RunLoop.end();
    },
    hidePlayerGUI: function() {
      var playPause, radialProgress;
      if (this._hooCanvas != null) {
        radialProgress = this._smallPlayerFrontEnd._radialProgress;
        playPause = this._smallPlayerFrontEnd._playPauseButton;
        this.removeObserver('_loadProgress', radialProgress, radialProgress.loadDidChange);
        this.removeObserver('_playProgress', radialProgress, radialProgress.playDidChange);
        this.removeObserver('_busyFlag', radialProgress, radialProgress.busyDidChange);
        this.removeObserver('_ready', playPause, 'enabledDidChange');
        this._hooCanvas.removeAllSubviews();
        this._hooCanvas.swapOutFor(this._placeHolder$);
        return this._hooCanvas = null;
      }
    },
    ready: function() {
      return 0;
    },
    durationchange: function() {
      return this._fakeLoadProgressEvent();
    },
    _fakeLoadProgressEvent: function() {
      var loadedDegrees, reportedLoadedDegress;
      loadedDegrees = this._loadProgress;
      reportedLoadedDegress = this._playerBackend.loadedDegrees();
      if (loadedDegrees !== reportedLoadedDegress) {
        this.animateProperty('_loadProgress', reportedLoadedDegress, 1000 / 25 * 10);
      }
      return this.set('_busyFlag', false);
    },
    progressupdate: function() {
      var actualLoadedDegrees;
      actualLoadedDegrees = this._playerBackend.loadedDegrees();
      if (actualLoadedDegrees > 0) {
        this.set('_busyFlag', false);
      }
      return this.animateProperty('_loadProgress', actualLoadedDegrees, 1000 / 25 * 10);
    },
    _showPlay: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState1");
    },
    _showPause: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState2");
    },
    _showDisabled: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState1");
    },
    timeupdate: function() {
      return this.animateProperty('_playProgress', this._playerBackend.playedDegrees(), 1000 / 25 * 10);
    },
    cmd_showEmptyLoader: function() {
      jQuery(this).stop();
      this.coldSetProperty('_loadProgress', 0);
      this.coldSetProperty('_playProgress', 0);
      return this.set('_busyFlag', false);
    },
    cmd_showStalledLoader: function() {
      if (this._loadProgress > 350) {
        return 0;
      } else {
        return this.set('_busyFlag', true);
      }
    },
    cmd_showLoadingLoader: function() {
      return this.set('_busyFlag', true);
    },
    cmd_showErrorLoader: function() {
      this._showDisabled();
      return this.set('_busyFlag', true);
    },
    cmd_showEmptyPlayer: function() {
      return this._showDisabled();
    },
    cmd_showStoppedPlayer: function() {
      return this._showPlay();
    },
    cmd_showWaitingPlayer: function() {
      return this.set('_busyFlag', true);
    },
    cmd_hideWaitingPlayer: function() {
      return this.set('_busyFlag', false);
    },
    cmd_showPlayingPlayer: function() {
      return this._showPause();
    },
    cmd_showFinishedPlayer: function() {
      jQuery(this).stop();
      this.coldSetProperty('_playProgress', 0);
      this._playerBackend.pause();
      return this._playerBackend.setCurrentTime(0);
    },
    cmd_showErrorPlayer: function() {
      return this._showDisabled();
    }
  }, (function() {
    /* Button Actions */
  })(), {
    playClickAction: function() {
      return this._playerBackend.play();
    },
    pauseClickAction: function() {
      return this._playerBackend.pause();
    }
  });
}).call(this);

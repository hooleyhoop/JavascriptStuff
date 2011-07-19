/* DO NOT MODIFY. This file was compiled Tue, 19 Jul 2011 15:42:58 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/headless-player.coffee
 */

(function() {
  /* abstract superclass for flash and html5
  */  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.NewAbstractHeadlessPlayerSingleton = SC.Object.extend({
    _audioPlayingDomNode: void 0,
    _mp3url: void 0,
    setSrc: function(mp3Url2, autoload, autoplay) {
      var autoloadsetting;
      HOO_nameSpace.assert(mp3Url2, "you need the mp3 url");
      HOO_nameSpace.assert(autoload, "html5 autoload stinks concerning the events it sends - just setSrc when you want to load");
      if (this._mp3url !== mp3Url2) {
        this._mp3url = mp3Url2;
        console.log("SRC: " + mp3Url2);
        if (autoplay) {
          this._audioPlayingDomNode.attrSetter('autoplay', 'autoplay');
          autoload = true;
        }
        autoloadsetting = "none";
        if (autoload) {
          autoloadsetting = "auto";
        }
        this._audioPlayingDomNode.attrSetter('preload', autoloadsetting);
        this._audioPlayingDomNode.attrSetter('src', mp3Url2);
        if (autoload) {
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
        HOO_nameSpace.assert(timeRanges.length === 1, "you need the mp3 url");
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
      return playedDegrees;
    },
    play: function() {
      return this._audioPlayingDomNode.cmd('play');
    },
    pause: function() {
      return this._audioPlayingDomNode.cmd('pause');
    },
    currentTime: function() {
      return this._audioPlayingDomNode.attrGetter('currentTime');
    },
    setCurrentTime: function(secs) {
      if (secs !== this.currentTime()) {
        return this._audioPlayingDomNode.setNodeProperty('currentTime', secs);
      }
    }
  });
  SC.mixin(ABoo.NewAbstractHeadlessPlayerSingleton, ABoo.SingletonClassMethods);
  /*
   * Only one of these per page
  */
  ABoo.NewHTML5HeadlessPlayerSingleton = ABoo.NewAbstractHeadlessPlayerSingleton.extend({
    _headlessAudioOb: void 0,
    init: function() {
      this._super();
      this._headlessAudioOb = ABoo.HeadlessSharedDomNodeProxy.sharedDivForTag("audio");
      return this._audioPlayingDomNode = this._headlessAudioOb;
    },
    _getTimeRangeEnd: function(timeRanges, timeRangeIndex) {
      return timeRanges.end(timeRangeIndex);
    }
  });
  SC.mixin(ABoo.NewHTML5HeadlessPlayerSingleton, ABoo.SingletonClassMethods);
  /*
   * Only one of these per page
  */
  ABoo.NewFlashHeadlessPlayerSingleton = ABoo.NewAbstractHeadlessPlayerSingleton.extend({
    _swfSrc: "HeadlessPlayer/lib/Debug/HeadlessPlayer",
    _headlessFlashOb: void 0,
    init: function() {
      var flashURL;
      this._super();
      flashURL = ABoo.HeadlessSharedFlashObject.uRLForSwf(this._swfSrc);
      this._headlessFlashOb = ABoo.HeadlessSharedFlashObject.sharedSwfForURL(flashURL, '100%', '100%', {
        autostart: 'load'
      });
      return this._audioPlayingDomNode = this._headlessFlashOb;
    },
    _getTimeRangeEnd: function(timeRanges, timeRangeIndex) {
      return timeRanges[timeRangeIndex][1];
    }
  });
  SC.mixin(ABoo.NewFlashHeadlessPlayerSingleton, ABoo.SingletonClassMethods);
  /* one of these for each instance of a player
  */
  ABoo.NewAbstractHeadlessPlayerBackend = SC.Object.extend({
    _mp3URL: void 0,
    _controller: void 0,
    _watchableEvents: 'error emptied loadstart progress loadeddata loadedmetadata durationchange timeupdate canplay canplaythrough waiting play ended abort dataunavailable empty pause ratechange seeked seeking volumechange stalled',
    _stateMachine: void 0,
    _state: false,
    _headLessSingleton: void 0,
    _autoload: true,
    _autoplay: false,
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
      return this._headLessSingleton.setSrc(this._mp3URL, this._autoload, this._autoplay);
    },
    _createObservervations: function() {
      var $actualPlayer;
      $actualPlayer = $(this._headLessSingleton._audioPlayingDomNode._observableSwf);
      return $actualPlayer.bind(this._watchableEvents, __bind(function(e) {
        var run;
        if (e.type === "timeupdate" && this.playedDegrees() === 0) {
          return console.log("Timeupdate at zero - do we need this to reset clock? like when played thru?");
        } else {
          run = SC.run.begin();
          this.handleHeadlessFlashPlayerEvent(e.type);
          return SC.run.end();
        }
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
    duration: function() {
      return this._headLessSingleton.duration();
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
    currentTime: function() {
      return this._headLessSingleton.currentTime();
    },
    setCurrentTime: function(secs) {
      return this._headLessSingleton.setCurrentTime(secs);
    },
    setProgressPercent: function(arg) {
      var newVal;
      newVal = this.duration() * arg;
      if (newVal >= this.duration()) {
        newVal = this.duration() - 0.5;
      }
      if (newVal < 0) {
        newVal = 0.01;
      }
      return this.setCurrentTime(newVal);
    }
  });
  /*
   * One of these for each instance on the page
  */
  ABoo.NewFlashHeadlessPlayerBackend = ABoo.NewAbstractHeadlessPlayerBackend.extend({
    _createSingletonPlayer: function() {
      return this._headLessSingleton = ABoo.NewFlashHeadlessPlayerSingleton.sharedInstance();
    }
  });
  /*
   * One of these for each instance on the page
  */
  ABoo.NewHtml5HeadlessPlayerBackend = ABoo.NewAbstractHeadlessPlayerBackend.extend({
    _createSingletonPlayer: function() {
      return this._headLessSingleton = ABoo.NewHTML5HeadlessPlayerSingleton.sharedInstance();
    }
  });
  /* one of these for each instance of a player
  */
  ABoo.NewAbstractPlayer = ABoo.SCView.extend({
    _playerBackend: void 0,
    _ready: false,
    _loadProgress: 0,
    _playProgress: 0,
    _busyFlag: false,
    ready: function() {
      return this.set('_ready', true);
    },
    cmd_showEmptyLoader: function() {
      jQuery(this).stop();
      this.coldSetProperty('_loadProgress', 0);
      this.coldSetProperty('_playProgress', 0);
      return this.set('_busyFlag', false);
    },
    cmd_showStalledLoader: function() {
      var reportedLoadedDegress;
      reportedLoadedDegress = this._playerBackend.loadedDegrees();
      if (this.reportedLoadedDegress > 350) {
        return 0;
      } else {
        return this.set('_busyFlag', true);
      }
    },
    cmd_showLoadingLoader: function() {
      return this.set('_busyFlag', true);
    },
    cmd_showResettingLoader: function() {
      return 0;
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
  ABoo.NewAbstractSmallPlayer = ABoo.NewAbstractPlayer.extend({
    _hooCanvas: void 0,
    _placeHolder$: void 0,
    _smallPlayerFrontEnd: void 0,
    didInsertElement: function() {
      var noJsAnchor$;
      this._super();
      noJsAnchor$ = this.getFirstDomItemOfType("a");
      noJsAnchor$.remove();
      this._placeHolder$ = this.getFirstDomItemOfType("img");
      return this.createPlayerBackend();
    },
    createPlayerBackend: function() {
      /*
      			This is where you customize...
      		*/      return 0;
    },
    mouseUp: function(ev$) {
      if (this._playerBackend._state === false) {
        if (this._placeHolder$) {
          return this._playerBackend._attachToPage(this._placeHolder$);
        }
      }
    },
    showPlayerGUI: function() {
      var playPause, radialProgress, thePlayButtonJson, theRadialProgressJson;
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
      return this._smallPlayerFrontEnd.setupDidComplete();
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
    _showPlay: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState1");
    },
    _showPause: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState2");
    },
    _showDisabled: function() {
      return this._smallPlayerFrontEnd._playPauseButton._buttonSMControl.sendEvent("ev_showState1");
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
    timeupdate: function() {
      return this.animateProperty('_playProgress', this._playerBackend.playedDegrees(), 1000 / 25 * 10);
    },
    description: function() {
      return "small player " + this._super();
    }
  });
}).call(this);

/* DO NOT MODIFY. This file was compiled Thu, 07 Jul 2011 17:28:17 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/widgets/buttons/hoo_play_pause_button.coffee
 */

(function() {
  ABoo.HooPlayPauseButtonGraphic = ABoo.HooAbstractButtonGraphic.extend(ABoo.HooCanvasViewMixin, {
    _playButtonSprite: void 0,
    _pauseButtonSprite: void 0,
    _currentSpriteState: void 0,
    _currentSprite: void 0,
    _percentOfCanvas: void 0,
    _threeStateButtonStateMachine_config: {
      "disabled": {
        "movieclip": "_playButtonSprite",
        "properties": {
          _isDisabled: true,
          _isDown: false
        }
      },
      "play": {
        "movieclip": "_playButtonSprite",
        "properties": {
          _isDisabled: false,
          _isDown: false
        }
      },
      "play_down": {
        "movieclip": "_playButtonSprite",
        "properties": {
          _isDisabled: false,
          _isDown: true
        }
      },
      "pause": {
        "movieclip": "_pauseButtonSprite",
        "properties": {
          _isDown: false
        }
      },
      "pause_down": {
        "movieclip": "_pauseButtonSprite",
        "properties": {
          _isDown: true
        }
      }
    },
    init: function() {
      this._super();
      this._playButtonSprite = ABoo.PlayButtonSprite.create();
      return this._pauseButtonSprite = ABoo.PauseButtonSprite.create();
    },
    description: function() {
      return "HooPlayPauseButtonGraphic";
    },
    getClickableItem: function() {
      HOO_nameSpace.assert(this._parentCanvas, "this button must be added to a canvas to work");
      return this._parentCanvas._$canvas;
    },
    drawContents: function(ctx, width, height) {
      var insetHeight, insetWidth, x, y;
      if (!this._currentSprite) {
        return;
      }
      insetWidth = width * this._percentOfCanvas;
      insetHeight = height * this._percentOfCanvas;
      x = (width - insetWidth) / 2.0;
      y = (height - insetHeight) / 2.0;
      return this._currentSprite.spriteDraw(ctx, x, y, insetWidth, insetHeight);
    },
    showDisabledButton: function() {
      return this.transitionToSpriteState("disabled");
    },
    showMouseUp1State: function() {
      return this.transitionToSpriteState("play");
    },
    showMouseDown1State: function() {
      return this.transitionToSpriteState("play_down");
    },
    showMouseUp2State: function() {
      return this.transitionToSpriteState("pause");
    },
    showMouseDown2State: function() {
      return this.transitionToSpriteState("pause_down");
    },
    transitionToSpriteState: function(state) {
      var shouldBePropertyValuesDict, shouldBeVisibleSpriteName, stateDict;
      if (state !== this._currentSpriteState) {
        stateDict = this._threeStateButtonStateMachine_config[state];
        shouldBeVisibleSpriteName = stateDict["movieclip"];
        this._currentSprite = this.get(shouldBeVisibleSpriteName);
        shouldBePropertyValuesDict = stateDict["properties"];
        this._currentSprite.setPropertiesOfSprite(shouldBePropertyValuesDict);
        this._currentSpriteState = state;
        if (this._parentCanvas) {
          return this._parentCanvas.setNeedsDisplay();
        }
      }
    },
    getOuterWidth: function() {
      debugger;
    },
    setOuterWidth: function(arg) {
      debugger;
    },
    getTextContent: function() {
      debugger;
    },
    getHref: function() {
      debugger;
    },
    setBackgroundAndTextState: function(state) {
      debugger;
    },
    setContentText: function(arg) {
      debugger;
    },
    positionBackground: function(state) {
      debugger;
    }
  });
  ABoo.HooPlayPauseButton = ABoo.HooFormButtonToggle.extend({
    _hooCanvas: void 0,
    _createGraphic: function() {
      return ABoo.HooPlayPauseButtonGraphic.create({
        _rootItemId: this.id,
        _percentOfCanvas: this.json.percentOfCanvas
      });
    },
    setupDidComplete: function() {
      HOO_nameSpace.assert(this._hooCanvas, "this button must be added to a canvas to work");
      this._hooCanvas.addSubview(this._buttonGraphic);
      return this._super();
    }
  });
  ABoo.SmallPlayerPlayButton = ABoo.HooWidget.extend({
    _radialProgress: void 0,
    _playPauseButton: void 0,
    init: function() {
      return this._super();
    },
    setupDidComplete: function() {
      var BINDINGSTEST, debugOnly;
      BINDINGSTEST = false;
      if (BINDINGSTEST) {
        debugOnly = ABoo.SimpleCounterForBindingsDebugging.create({
          _rate: 1000
        });
        debugOnly.addObserver('_flag', this._playPauseButton, 'enabledDidChange');
      }
      return 0;
    }
  });
}).call(this);

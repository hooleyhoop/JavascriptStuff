/* DO NOT MODIFY. This file was compiled Mon, 18 Jul 2011 16:32:34 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/widgets/buttons/three_state_item.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.HooThreeStateItem = ABoo.HooWidget.extend({
    _buttonSM: void 0,
    _graphic: void 0,
    _clickableItem$: void 0,
    _target: void 0,
    _action: void 0,
    _actionArg: void 0,
    _isAsync: void 0,
    init: function() {
      this._super();
      this._createSM();
      this._graphic.showDisabledButton();
      return this._listenerDebugger = ABoo.ActiveListenerDebugger.create();
    },
    _createSM: function() {
      return this._buttonSM = ABoo.ThreeStateButtonStateMachine.create({
        _controller: this
      });
    },
    setButtonTarget: function(target, action, arg, isAsync) {
      this._target = target;
      this._action = action;
      this._actionArg = arg;
      return this._isAsync = isAsync;
    },
    sendEvent: function(ev) {
      return this._buttonSM.processInputSignal(ev);
    },
    cmd_enableButton: function() {
      HOO_nameSpace.assert(this._clickableItem$, "did we set this up properly?");
      return this._listenerDebugger.addListener(this._clickableItem$, 'mousedown', this, this._mouseDown);
    },
    cmd_disableButton: function() {
      this._listenerDebugger.removeListener(this._clickableItem$, 'mousedown', this, this._mouseDown);
      return this._graphic.showDisabledButton();
    },
    cmd_showMouseUp1: function() {
      return this._graphic.showMouseUp1State();
    },
    cmd_showMouseDown1: function() {
      return this._graphic.showMouseDown1State();
    },
    cmd_showMouseDownOut1: function() {
      return this._graphic.showMouseUp1State();
    },
    cmd_fireButtonAction1: function() {
      this._fire("ev_showState1");
      return 0;
    },
    _fire: function(nextState) {
      /*
      		TODO:
      		how do we handle toggle button?
      		how do we handle async actions?
      		how do we go back to the correct state?
      		*/      var actionToCall, completionCallback, onCompleteStuffHash;
      completionCallback = __bind(function() {
        return this.sendEvent(nextState);
      }, this);
      onCompleteStuffHash = {
        onCompleteTarget: this,
        onCompleteAction: completionCallback
      };
      if (this._target) {
        actionToCall = this._action;
        if ($.isArray(actionToCall)) {
          HOO_nameSpace.assert(actionToCall.length === 2, "If actions is an array it must have exactly 2 actions");
          if (nextState === "ev_showState1") {
            actionToCall = actionToCall[1];
          } else {
            actionToCall = actionToCall[0];
          }
        }
        if (typeof actionToCall === 'string') {
          actionToCall = this._target[actionToCall];
        }
        actionToCall.call(this._target, this._actionArg, onCompleteStuffHash);
      }
      if (this._isAsync === false) {
        return completionCallback();
      }
    },
    cmd_abortClickAction: function() {
      return this.sendEvent("ev_clickAbortCompleted");
    },
    _mouseDown: function(e) {
      this._listenerDebugger.addListener($(document), 'mouseup', this, this._mouseStageUp);
      this._clickableItem$.unselectable = "on";
      this._clickableItem$.onselectstart = function() {
        return false;
      };
      this._listenerDebugger.addListener(this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler);
      this._listenerDebugger.addListener(this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler);
      this.sendEvent("ev_buttonPressed");
      return e.preventDefault();
    },
    _mouseStageUp: function(e) {
      this._listenerDebugger.removeListener($(document), 'mouseup', this, this._mouseStageUp);
      this._listenerDebugger.removeListener(this._clickableItem$, 'mouseleave', this, this._mouseRollOutHandler);
      this._listenerDebugger.removeListener(this._clickableItem$, 'mouseenter', this, this._mouseRollOverHandler);
      this.sendEvent("ev_buttonReleased");
      return e.preventDefault();
    },
    _mouseRollOutHandler: function(e) {
      return this.sendEvent("ev_mouseDraggedOutside");
    },
    _mouseRollOverHandler: function(e) {
      return this.sendEvent("ev_mouseDraggedInside");
    },
    currentStateName: function() {
      return this._buttonSM.currentStateName();
    },
    setCurrentStateName: function(arg) {
      return this._buttonSM.processInputSignal(arg);
    }
  });
  /*
   * Append a couple of states to 3 state button
  */
  ABoo.HooFiveStateItem = ABoo.HooThreeStateItem.extend({
    _createSM: function() {
      return this._buttonSM = ABoo.FiveStateButtonStateMachine.create({
        _controller: this
      });
    },
    cmd_showMouseDown2: function() {
      return this._graphic.showMouseDown2State();
    },
    cmd_showMouseUp2: function() {
      return this._graphic.showMouseUp2State();
    },
    cmd_showMouseDownOut2: function() {
      return this._graphic.showMouseDown2State();
    },
    cmd_fireButtonAction1: function() {
      return this._fire("ev_showState2");
    },
    cmd_fireButtonAction2: function() {
      return this._fire("ev_showState1");
    }
  });
  /*
  
  */
  ABoo.HooSliderItem = ABoo.HooThreeStateItem.extend({
    _lastMouseEvent: void 0,
    _mouseDown: function(e) {
      this._listenerDebugger.addListener($(document), 'mousemove', this, this._mouseDragged);
      this._lastMouseEvent = e;
      return this._super(e);
    },
    _mouseDragged: function(e) {
      this._lastMouseEvent = e;
      return this._fire();
    },
    _mouseStageUp: function(e) {
      this._listenerDebugger.removeListener($(document), 'mousemove', this, this._mouseDragged);
      this._lastMouseEvent = e;
      return this._super(e);
    },
    _fire: function(nextState) {
      var percent, pos, x;
      if (this._target) {
        x = this._lastMouseEvent.pageX;
        pos = this._clickableItem$.offset();
        percent = ABoo.HooMath.xAsUnitPercentOfY(x - pos.left, this._clickableItem$.width());
        if (typeof this._action === 'string') {
          this._action = this._target[this._action];
        }
        return this._action.call(this._target, percent);
      }
    }
  });
}).call(this);

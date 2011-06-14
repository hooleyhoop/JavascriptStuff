/* DO NOT MODIFY. This file was compiled Mon, 06 Jun 2011 17:04:05 GMT from
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
      return this._fire("ev_showState1");
    },
    _fire: function(nextState) {
      /*
      		TODO:
      		how do we handle toggle button?
      		how do we handle async actions?
      		how do we go back to the correct state?
      		*/      var completionCallback, onCompleteStuffHash;
      completionCallback = __bind(function() {
        return this.sendEvent(nextState);
      }, this);
      onCompleteStuffHash = {
        onCompleteTarget: this,
        onCompleteAction: completionCallback
      };
      if (this._target) {
        this._action.call(this._target, this._actionArg, onCompleteStuffHash);
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
      this._listenerDebugger.removeListener($(window), 'mouseup', this, this._mouseStageUp);
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
}).call(this);
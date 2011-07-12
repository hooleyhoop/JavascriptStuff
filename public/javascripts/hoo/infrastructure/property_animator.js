/* DO NOT MODIFY. This file was compiled Tue, 12 Jul 2011 15:53:20 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/property_animator.coffee
 */

(function() {
  ABoo.BusyFadeHelper = SC.Object.extend({
    _fadeTimeStart: void 0,
    _fadeTimeEnd: void 0,
    _fadeStartVal: void 0,
    _fadeEndVal: void 0,
    _fadeComplete: void 0,
    _target: void 0,
    _property: void 0,
    _ended: void 0,
    animate: function(target, property, endVal, duration, completeCallback) {
      this._target = target;
      this._property = property;
      this._fadeStartVal = target.get(property);
      this._fadeEndVal = endVal;
      this._fadeTimeStart = new Date().getTime();
      this._fadeTimeEnd = this._fadeTimeStart + duration;
      this._fadeComplete = completeCallback;
      return this._ended = false;
    },
    update: function(time) {
      var updatedVal;
      if (this._ended) {
        this._didEnd();
        return;
      }
      updatedVal;
      if (time > this._fadeTimeEnd) {
        updatedVal = this._fadeEndVal;
        this._ended = true;
      } else {
        updatedVal = ABoo.HooMath.lerp(this._fadeTimeStart, this._fadeStartVal, this._fadeTimeEnd, this._fadeEndVal, time);
      }
      if (isNaN(updatedVal)) {
        debugger;
      }
      return this._target.set(this._property, updatedVal);
    },
    _didEnd: function() {
      this._fadeComplete();
      return this._fadeComplete = null;
    },
    timeUpdate: function(time) {
      return this.update(time);
    }
  });
}).call(this);

/* DO NOT MODIFY. This file was compiled Mon, 18 Jul 2011 17:01:46 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/property_animator.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.HooPropertyAnimator = SC.Object.extend({
    _fadeTimeStart: void 0,
    _fadeTimeEnd: void 0,
    _fadeStartVal: void 0,
    _fadeEndVal: void 0,
    _fadeComplete: void 0,
    _target: void 0,
    _property: void 0,
    _ended: void 0,
    init: function() {
      return this._super;
    },
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
      var skippedLerp, updatedVal;
      if (this._ended) {
        this._didEnd();
        return;
      }
      skippedLerp = false;
      if (time <= this._fadeTimeStart) {
        updatedVal = this._fadeStartVal;
      } else if (time >= this._fadeTimeEnd) {
        updatedVal = this._fadeEndVal;
        this._ended = true;
        skippedLerp = true;
      } else {
        updatedVal = ABoo.HooMath.lerp(this._fadeTimeStart, this._fadeStartVal, this._fadeTimeEnd, this._fadeEndVal, time);
        if (isNaN(updatedVal)) {
          debugger;
        }
      }
      return this._target.set(this._property, updatedVal);
    },
    _didEnd: function() {
      this._fadeComplete();
      return this._fadeComplete = null;
    },
    timeUpdate: function(time) {
      HOO_nameSpace.assert(time, "time? time? time?");
      return this.update(time);
    },
    forceSetValue: function(val) {
      return this._target.set(this._property, val);
    }
  });
  ABoo.PropertyAnimMixin = {
    _propertyAnimations: void 0,
    animateProperty: function(propertyName, to, duration) {
      var animComplete, animator;
      if (!this._propertyAnimations) {
        this._propertyAnimations = new Object();
      }
      animator = this._propertyAnimations[propertyName];
      if (!animator) {
        animator = ABoo.HooPropertyAnimator.create();
        ABoo.ShiteDisplayLink.sharedDisplayLink.registerListener(animator);
        this._propertyAnimations[propertyName] = animator;
      }
      animComplete = __bind(function() {
        ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener(animator);
        return this._propertyAnimations[propertyName] = null;
      }, this);
      return animator.animate(this, propertyName, to, duration, animComplete);
    },
    coldSetProperty: function(propertyName, to) {
      var animator;
      if (this._propertyAnimations != null) {
        animator = this._propertyAnimations[propertyName];
        if (animator != null) {
          ABoo.ShiteDisplayLink.sharedDisplayLink.unregisterListener(animator);
          animator.forceSetValue(to);
          animator._fadeComplete = null;
          return this._propertyAnimations[propertyName] = null;
        }
      } else {
        return this.set(propertyName, to);
      }
    }
  };
}).call(this);

/* DO NOT MODIFY. This file was compiled Wed, 13 Jul 2011 17:09:53 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/shite-display-link.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.ShiteDisplayLink = SC.Object.extend({
    _listeners: void 0,
    _canvasElements: void 0,
    _running: false,
    _timer: void 0,
    _time: 0,
    init: function() {
      this._super();
      this._listeners = new Array();
      this._canvasElements = new Array();
      return this._time = (new Date()).getTime();
    },
    registerListener: function(listener) {
      this._listeners.push(listener);
      if (this._running === false && this._listeners.length > 0) {
        return this.start();
      }
    },
    unregisterListener: function(listener) {
      var i;
      i = this._listeners.indexOf(listener);
      if (i > -1) {
        this._listeners.splice(i, 1);
      }
      if (this._running && this._canvasElements.length === 0 && this._listeners.length === 0) {
        return this.stop();
      }
    },
    registerCanvas: function(canvas) {
      this._canvasElements.push(canvas);
      if (this._running === false && this._canvasElements.length > 0) {
        return this.start();
      }
    },
    unregisterCanvas: function(canvas) {
      var i, wasRunning;
      wasRunning = false;
      if (this._running) {
        this.stop();
        wasRunning = true;
      }
      i = this._canvasElements.indexOf(canvas);
      if (i > -1) {
        this._canvasElements.splice(i, 1);
      }
      if (wasRunning && (this._canvasElements.length > 0 || this._listeners.length > 0)) {
        return this.start();
      } else {
        return console.warn("Not restarting DSIPLAY LINK because: " + wasRunning(+" " + this._canvasElements.length + " " + this._listeners.length));
      }
    },
    start: function() {
      this._timer = setInterval(__bind(function() {
        return this._callback.call(this);
      }, this), 33);
      return this._running = true;
    },
    stop: function() {
      clearInterval(this._timer);
      this._timer = null;
      return this._running = false;
    },
    _callback: function() {
      var canvasElementsCopy, listenersCopy, t;
      HOO_nameSpace.assert(this._canvasElements.length > 0 || this._listeners.length > 0, "why am i drawing with no listeners or canvases?");
      this._time = (new Date()).getTime();
      t = this._time;
      listenersCopy = this._listeners.slice(0);
      $.each(listenersCopy, function(indexInArray, valueOfElement) {
        return valueOfElement.timeUpdate(t);
      });
      canvasElementsCopy = this._canvasElements.slice(0);
      return $.each(canvasElementsCopy, function(indexInArray, valueOfElement) {
        return valueOfElement.displayUpdate(t);
      });
    }
  });
  ABoo.ShiteDisplayLinkClassMethods = {
    sharedDisplayLink: void 0
  };
  SC.mixin(ABoo.ShiteDisplayLink, ABoo.ShiteDisplayLinkClassMethods);
  ABoo.ShiteDisplayLink.sharedDisplayLink = ABoo.ShiteDisplayLink.create();
}).call(this);

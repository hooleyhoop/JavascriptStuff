/* DO NOT MODIFY. This file was compiled Thu, 30 Jun 2011 15:31:13 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/widgets/flippy_toggle_thing.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.DebugView = SC.View.extend({
    firstBindingTest: "version 2 - I have no idea!!",
    normalClass: "steve",
    remaining: 2,
    mouseDown: function() {
      return console.log("!!clicky clicky doHicky!!!..");
    },
    flippyStateDidChange: function() {
      return alert("yay! i can go home now?");
    },
    remainingString: (function() {
      var remaining, _ref;
      remaining = this.get('remaining');
      return remaining + ((_ref = remaining === 1) != null ? _ref : {
        " item": " items"
      });
    }).property('remaining').cacheable()
  });
  ABoo.Gui_Views_Debug_FlippyToggleThing = ABoo.SCView.extend({
    _flippyState: false,
    view2: void 0,
    init: function() {
      return this._super();
    },
    setupDidComplete: function() {
      var template;
      console.log("oh bisto..");
      this.div$.bind('click', __bind(function(e) {
        return this.flippyFlip();
      }, this));
      this.view2 = ABoo.DebugView.create();
      template = SC.Handlebars.compile("<div {{bindAttr class=\"normalClass\"}} style='font-size:16px; background-color:orange'>{{firstBindingTest}}<div>");
      this.view2.set("template", template);
      this.view2.appendTo(this.div$);
      this.view2.set('parentView', this);
      return this.addObserver('_flippyState', this.view2, this.view2.flippyStateDidChange);
    },
    flippyFlip: function() {
      SC.RunLoop.begin();
      this.set('_flippyState', !this._flippyState);
      this.updateGraphics();
      return SC.RunLoop.end();
    },
    updateGraphics: function() {
      if (this._flippyState) {
        return this.div$.css("background-color", "#000");
      } else {
        return this.div$.css("background-color", "#ff0000");
      }
    }
  });
}).call(this);

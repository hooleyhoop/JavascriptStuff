/* DO NOT MODIFY. This file was compiled Fri, 17 Jun 2011 11:09:28 GMT from
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
  ABoo.HackedWidget = SC.View.extend(ABoo.RootObject, (function() {
    /*
    		id + json are set when created
    		we could rationalise this a bit..
    		sproutcore this[SC.GUID_KEY] is the same as out id
    		sproutcore's element is the same as our div$
    	*/
  })(), {
    init: function() {
      return this._super();
    },
    didCreateElement: function() {
      return this._super();
    },
    parentDidResize: function() {
      return console.log("oh reeally..");
    },
    mouseDown: function() {
      return console.log("pfft! pffft! pffft! ..");
    }
  });
  ABoo.GUI_Views_Debug_FlippyToggleThing = ABoo.HackedWidget.extend({
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

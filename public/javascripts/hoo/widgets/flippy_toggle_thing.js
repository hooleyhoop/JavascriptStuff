/* DO NOT MODIFY. This file was compiled Tue, 07 Jun 2011 14:30:30 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/widgets/flippy_toggle_thing.coffee
 */

(function() {
  ABoo.DebugView = SC.View.extend({
    mouseDown: function() {
      return console.log("!!clicky clicky doHicky!!!..");
    }
  });
  ABoo.HackedWidget = ABoo.HooWidget.extend({
    json: void 0,
    id: void 0,
    div$: void 0,
    init: function() {
      var template, view2;
      this._super();
      if (!this.div$) {
        this.div$ = $("#" + this.id);
      }
      view2 = ABoo.DebugView.create();
      template = SC.Handlebars.compile("<div style='font-size:21px; background-color:orange'>why why why??????<div>");
      view2.set("template", template);
      return view2.appendTo(this.div$);
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
    init: function() {
      return this._super();
    },
    setupDidComplete: function() {
      return console.log("oh bisto..");
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

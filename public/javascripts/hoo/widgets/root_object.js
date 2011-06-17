/* DO NOT MODIFY. This file was compiled Fri, 17 Jun 2011 09:49:50 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/widgets/root_object.coffee
 */

(function() {
  ABoo.RootObject = SC.Mixin.create({
    json: void 0,
    id: void 0,
    div$: void 0,
    init: function() {
      if (this.id != null) {
        this[SC.GUID_KEY] = this.id;
      }
      this.div$ || (this.div$ = $("#" + this.id));
      return this._super();
    },
    parentDidResize: function() {
      return 0;
    },
    getFirstDomItemOfType: function(type) {
      var $item;
      $item = this.div$.find(type + ":first");
      if ($item.length !== 1) {
        console.error("Could not find the " + type + " dom item");
        return null;
      }
      return $item;
    },
    swapFindAndSwapInstanceVariableNamed: function(jsonProp, iVarName) {
      var value;
      value = null;
      if (HOO_nameSpace[jsonProp]) {
        value = HOO_nameSpace[jsonProp];
      } else {
        debugger;
      }
      return this.set(iVarName, value);
    }
  });
  ABoo.Bindings = SC.Mixin.create({
    bindToTarget: function(target, propertyName, observer, observerDidChangeMethod) {
      target.addObserver(propertyName, observer, observerDidChangeMethod);
      return observer[observerDidChangeMethod].call(observer, target, propertyName);
    },
    unbindToTarget: function(target, propertyName, observer, observerDidChangeMethod) {
      return target.removeObserver(propertyName, observer, observerDidChangeMethod);
    }
  });
}).call(this);

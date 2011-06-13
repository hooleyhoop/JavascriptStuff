/* DO NOT MODIFY. This file was compiled Mon, 13 Jun 2011 14:42:32 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/tests/sproutcore_object_tests.coffee
 */

(function() {
  module("Sproutcore 2 Object", {
    setup: function() {}
  });
  ABoo.AMixinTest1 = SC.Mixin.create({
    _age: void 0,
    init: function() {
      HOO_nameSpace.assert(this._age != null, "doh");
      this._super();
      HOO_nameSpace.assert(this._age != null, "doh");
      return this;
    }
  });
  ABoo.SimpleInheritanceTest1 = SC.Object.extend({
    _name: void 0,
    init: function() {
      HOO_nameSpace.assert(this._name != null, "doh");
      this._super();
      HOO_nameSpace.assert(this._name != null, "doh");
      return this;
    }
  });
  ABoo.SimpleInheritanceTest2 = ABoo.SimpleInheritanceTest1.extend({
    init: function() {
      HOO_nameSpace.assert(this._name != null, "doh");
      this._super();
      HOO_nameSpace.assert(this._name != null, "doh");
      return this;
    }
  });
  ABoo.SimpleInheritanceTest3 = ABoo.SimpleInheritanceTest1.extend(ABoo.AMixinTest1, {
    init: function() {
      HOO_nameSpace.assert(this._name != null, "doh");
      this._super();
      HOO_nameSpace.assert(this._name != null, "doh");
      return this;
    }
  });
  ABoo.SimpleInheritanceTest4 = SC.Object.extend({
    _age: void 0,
    init: function() {
      this._super();
      return this;
    }
  });
  test("url for flash", function() {
    var ob1, ob2, ob3;
    ob1 = ABoo.SimpleInheritanceTest1.create({
      _name: "panda"
    });
    equals(ob1.get("_name"), "panda", "!");
    ob2 = ABoo.SimpleInheritanceTest2.create({
      _name: "panda"
    });
    equals(ob2.get("_name"), "panda", "!");
    ob3 = ABoo.SimpleInheritanceTest3.create({
      _name: "panda",
      _age: 12
    });
    equals(ob3.get("_name"), "panda", "!");
    return equals(ob3.get("_age"), 12, "!");
  });
}).call(this);

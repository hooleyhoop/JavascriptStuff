/* DO NOT MODIFY. This file was compiled Thu, 07 Jul 2011 10:52:45 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/singleton.coffee
 */

(function() {
  ABoo.SingletonClassMethods = SC.Mixin.create({
    _sharedInstance: void 0,
    sharedInstance: function() {
      if (!(this._sharedInstance != null)) {
        this._sharedInstance = this.create();
      }
      return this._sharedInstance;
    }
  });
}).call(this);

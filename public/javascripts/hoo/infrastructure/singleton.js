/* DO NOT MODIFY. This file was compiled Tue, 12 Jul 2011 13:37:24 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/singleton.coffee
 */

(function() {
  ABoo.SingletonClassMethods = {
    _sharedInstance: void 0,
    sharedInstance: function() {
      if (!(this._sharedInstance != null)) {
        this._sharedInstance = this.create();
      }
      return this._sharedInstance;
    }
  };
}).call(this);

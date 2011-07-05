/* DO NOT MODIFY. This file was compiled Mon, 04 Jul 2011 09:48:35 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/div_object.coffee
 */

(function() {
  /*
  	HTML
  */  ABoo.DivObject = SC.Object.extend({
    _swfID: void 0,
    _commandableSwf: void 0,
    _observableSwf: void 0,
    _delegate: void 0,
    _ready: void 0,
    _tag: void 0,
    init: function() {
      this._super();
      this._swfID = ABoo.FlashObject.newID();
      this._observableSwf = document.createElement(this._tag);
      this._commandableSwf = this._observableSwf;
      this._ready = false;
      this._commandableSwf.getNodeProperty = function(propertyName) {
        return this[propertyName];
      };
      return this._commandableSwf.setNodeProperty = function(propertyName, value) {
        return this[propertyName] = value;
      };
    }
  }, (function() {
    /*
    		!important: everytime you move the swf it creates a new instance
    	*/
  })(), {
    appendToDiv: function(div$) {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this._observableSwf.appendTo(div$);
      return this.flashDidLoad();
    },
    remove: function() {
      return this._ready = false;
    },
    flashDidLoad: function() {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this._ready = true;
      return this._delegate.flashDidLoad(this);
    },
    setSwfSize: function(width, height) {
      this._observableSwf.width(width);
      return this._observableSwf.height(height);
    },
    matchSwfSizeToItem: function() {
      return this.setSwfSize(this._currentPlaceHolder.width(), this._currentPlaceHolder.height());
    }
  });
  ABoo.DivObjectClassMethods = SC.Mixin.create({
    newDivFortag: function(tag) {
      return ABoo.DivObject.create({
        _tag: tag
      });
    }
  });
  /*
  	Shared Div
  */
  ABoo.SharedDivObject = ABoo.DivObject.extend({
    _currentPlaceHolder: void 0,
    _activeScriptItem: void 0,
    swapInForItem: function(scriptItem, domItem$) {
      if (this._currentPlaceHolder != null) {
        this._observableSwf.after(this._currentPlaceHolder);
        this.remove();
      }
      this._currentPlaceHolder = domItem$;
      this.setActiveScriptItem(scriptItem);
      this.insertSwfVisibly();
      return this.flashDidLoad();
    },
    replacePlaceHolderWithSwf: function() {
      this._currentPlaceHolder.after(this._observableSwf);
      return this._currentPlaceHolder.remove();
    },
    insertSwfVisibly: function() {
      this.matchSwfSizeToItem();
      return this.replacePlaceHolderWithSwf();
    },
    setActiveScriptItem: function(item) {
      if (this._activeScriptItem != null) {
        this._activeScriptItem.didSwapOutFlash(this);
      }
      this._activeScriptItem = item;
      this._delegate = this._activeScriptItem;
      return this._activeScriptItem.didSwapInFlash(this);
    }
  });
  ABoo.SharedDivObjectClassMethods = SC.Mixin.create(ABoo.DivObjectClassMethods, {
    _cached: new Object(),
    sharedDivForTag: function(tag) {
      var cachedFlash;
      cachedFlash = this._cached[tag];
      if (!(cachedFlash != null)) {
        cachedFlash = this.create({
          _tag: tag
        });
        this._cached[tag] = cachedFlash;
      }
      return cachedFlash;
    }
  });
  /*
  	Shared Headless Flash
  */
  ABoo.HeadlessSharedDivObject = ABoo.SharedDivObject.extend({
    swapInForItem: function(scriptItem, domItem$) {
      if (this._currentPlaceHolder != null) {
        this.remove();
      }
      this._currentPlaceHolder = domItem$;
      this.setActiveScriptItem(scriptItem);
      this.insertSwfInvisibly();
      return this.flashDidLoad();
    },
    insertSwfInvisibly: function() {}
  });
  ABoo.HeadlessSharedDivObjectClassMethods = SC.Mixin.create(ABoo.SharedDivObjectClassMethods, {
    sharedDivForTag: function(tag) {
      var cachedFlash;
      cachedFlash = this._cached[tag];
      if (!(cachedFlash != null)) {
        cachedFlash = this.create({
          _tag: tag
        });
        this._cached[tag] = cachedFlash;
      }
      return cachedFlash;
    }
  });
  SC.mixin(ABoo.DivObject, ABoo.DivObjectClassMethods);
  SC.mixin(ABoo.SharedDivObject, ABoo.SharedDivObjectClassMethods);
  SC.mixin(ABoo.HeadlessSharedDivObject, ABoo.HeadlessSharedDivObjectClassMethods);
}).call(this);

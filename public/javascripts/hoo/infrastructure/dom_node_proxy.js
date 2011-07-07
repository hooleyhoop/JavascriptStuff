/* DO NOT MODIFY. This file was compiled Thu, 07 Jul 2011 09:25:37 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/dom_node_proxy.coffee
 */

(function() {
  /*
  	HTML
  */  ABoo.DomNodeProxy = SC.Object.extend({
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
      return this._ready = false;
    },
    getNodeProperty: function(propertyName) {
      return this._commandableSwf[propertyName];
    },
    setNodeProperty: function(propertyName, value) {
      return this._commandableSwf[propertyName] = value;
    },
    attrGetter: function(propertyName) {
      return this.getNodeProperty(propertyName);
    },
    attrSetter: function(propertyName, value) {
      return this._commandableSwf.setAttribute(propertyName, value);
    },
    cmd: function(functionName, argArray) {
      return this._commandableSwf[functionName].apply(this._commandableSwf, argArray);
    },
    appendToDiv: function(div$) {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this._observableSwf.appendTo(div$);
      return this.flashDidLoad();
    },
    flashDidLoad: function() {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this._ready = true;
      return this._delegate.flashDidLoad(this);
    },
    remove: function() {
      this._observableSwf.remove();
      return this._ready = false;
    },
    setSwfSize: function(width, height) {
      this._observableSwf.width(width);
      return this._observableSwf.height(height);
    },
    matchSwfSizeToItem: function() {
      return this.setSwfSize(this._currentPlaceHolder.width(), this._currentPlaceHolder.height());
    }
  });
  /*
  	DomNodeProxyClassMethods
  */
  ABoo.DomNodeProxyClassMethods = SC.Mixin.create({
    newDomNodeProxyFortag: function(tag) {
      return this.create({
        _tag: tag
      });
    }
  });
  SC.mixin(ABoo.DomNodeProxy, ABoo.DomNodeProxyClassMethods);
  /*
  	SharedDomNodeProxy
  */
  ABoo.SharedDomNodeProxy = ABoo.DomNodeProxy.extend({
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
  /*
  	SharedDomNodeProxyClassMethods
  */
  ABoo.SharedDomNodeProxyClassMethods = SC.Mixin.create(ABoo.DomNodeProxyClassMethods, {
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
  SC.mixin(ABoo.SharedDomNodeProxy, ABoo.SharedDomNodeProxyClassMethods);
  /*
  	HeadlessSharedDomNodeProxy
  */
  ABoo.HeadlessSharedDomNodeProxy = ABoo.SharedDomNodeProxy.extend({
    appendToDiv: function(div$) {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      return this.flashDidLoad();
    },
    swapInForItem: function(scriptItem, domItem$) {
      if (this._currentPlaceHolder != null) {
        this.remove();
      }
      this._currentPlaceHolder = domItem$;
      this.setActiveScriptItem(scriptItem);
      this.insertSwfInvisibly();
      return this.flashDidLoad();
    },
    remove: function() {
      return this._ready = false;
    },
    insertSwfInvisibly: function() {
      return 0;
    }
  });
  SC.mixin(ABoo.HeadlessSharedDomNodeProxy, ABoo.SharedDomNodeProxyClassMethods);
  /*
  	HeadlessSharedDomNodeProxyClassMethods
  */
}).call(this);

/* DO NOT MODIFY. This file was compiled Fri, 17 Jun 2011 09:24:49 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/hoo/infrastructure/flash_object.coffee
 */

(function() {
  /*
  	Flash
  */  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ABoo.FlashObject = SC.Object.extend({
    _url: void 0,
    _width: void 0,
    _height: void 0,
    _flashVarDict: void 0,
    _objectTagString: void 0,
    _swfID: void 0,
    _commandableSwf: void 0,
    _observableSwf: void 0,
    _delegate: void 0,
    _ready: void 0,
    _readyTimeout: void 0,
    _currentPlaceHolder: void 0,
    init: function() {
      var $wrapper;
      this._super();
      this._width || (this._width = "100%");
      this._height || (this._height = "100%");
      this._flashVarDict || (this._flashVarDict = new Object());
      this._swfID = ABoo.FlashObject.newID();
      this._objectTagString = ABoo.FlashObject.embedString(this._url, this._swfID, this._width, this._height, this._flashVarDict);
      $wrapper = $("<div class='swfHolder'/>");
      if ($.browser.msie) {
        $wrapper[0].innerHTML = this._objectTagString;
      } else {
        $wrapper.append(this._objectTagString);
      }
      this._observableSwf = $wrapper;
      this._commandableSwf = $wrapper.find('object')[0];
      return this._ready = false;
    }
  }, (function() {
    /*
    		!important: everytime you move the swf it creates a new instance?
    	*/
  })(), {
    appendToDiv: function(div$) {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this.addReadyBindingAndTimeOut();
      return this._observableSwf.appendTo(div$);
    },
    remove: function() {
      if (this._readyTimeout != null) {
        SC.run.cancel(this._readyTimeout);
      }
      this._observableSwf.remove();
      return this._ready = false;
    },
    addReadyBindingAndTimeOut: function() {
      this._observableSwf.bind('ready', __bind(function() {
        return this.flashDidLoad();
      }, this));
      return this._readyTimeout = SC.run.later(this, "readyDidTimeout", 1000);
    },
    readyDidTimeout: function() {
      this._readyTimeout = null;
      return 0;
    },
    flashDidLoad: function() {
      HOO_nameSpace.assert(this._ready === false, "ready called twice?");
      this._ready = true;
      SC.run.cancel(this._readyTimeout);
      this._readyTimeout = null;
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
  ABoo.FlashObjectClassMethods = SC.Mixin.create({
    _id: 0,
    newID: function() {
      return this._id++;
    },
    uRLForSwf: function(swfName) {
      return "/flash/" + swfName + ".swf";
    },
    newSwfForURL: function(swfURL, width, height, flashVarDict) {
      return ABoo.FlashObject.create({
        _url: swfURL,
        _width: width,
        _height: height,
        _flashVarDict: flashVarDict
      });
    },
    cachedSwfForURL: function() {
      return nil;
    },
    embedString: function(url, idNum, width, height, flashVarDict) {
      var flashVars;
      flashVarDict['rootID'] = idNum;
      flashVars = this.flashVarString(flashVarDict);
      return "<object data='" + url + "' id='" + idNum + "' type='application/x-shockwave-flash' width=" + width + " height=" + height + "><param name='movie' value='" + url + "'/><param name='allowScriptAccess' value='always'/><param name='FlashVars' value='" + flashVars + "'/></object>";
    },
    flashVarString: function(dict) {
      var flashVarString, key, newString, val;
      flashVarString = "";
      for (key in dict) {
        val = dict[key];
        newString = "" + key + "=" + val;
        flashVarString = flashVarString.length > 0 ? "" + flashVarString + "&" + newString : newString;
      }
      return flashVarString;
    }
  });
  /*
  	Shared Flash
  */
  ABoo.SharedFlashObject = ABoo.FlashObject.extend({
    _currentPlaceHolder: void 0,
    swapInForItem: function(item$) {
      if (this._currentPlaceHolder != null) {
        this._observableSwf.after(this._currentPlaceHolder);
        this.remove();
      }
      this.addReadyBindingAndTimeOut();
      this._currentPlaceHolder = item$;
      return this.replacePlaceHolderWithSwf();
    },
    replacePlaceHolderWithSwf: function() {
      this._currentPlaceHolder.after(this._observableSwf);
      return this._currentPlaceHolder.remove();
    }
  });
  ABoo.SharedFlashObjectClassMethods = SC.Mixin.create(ABoo.FlashObjectClassMethods, {
    _cached: new Object(),
    sharedSwfForURL: function(swfURL, width, height, flashVarDict) {
      var cachedFlash;
      cachedFlash = this._cached[swfURL];
      if (!(cachedFlash != null)) {
        cachedFlash = this.create({
          _url: swfURL,
          _width: width,
          _height: height,
          _flashVarDict: flashVarDict
        });
        this._cached[swfURL] = cachedFlash;
      }
      return cachedFlash;
    }
  });
  /*
  	Shared Headless Flash
  */
  ABoo.HeadlessSharedFlashObject = ABoo.SharedFlashObject.extend({
    _activeScriptItem: void 0,
    swapInForItem: function(scriptItem, domItem$) {
      if (this._currentPlaceHolder != null) {
        if (this._blocked) {
          this._observableSwf.after(this._currentPlaceHolder);
        }
        this.remove();
      }
      this._blocked = NO;
      this.addReadyBindingAndTimeOut();
      this.insertSwfInvisibly();
      this._currentPlaceHolder = domItem$;
      return this.setActiveScriptItem(scriptItem);
    },
    setActiveScriptItem: function(item) {
      if (this._activeScriptItem != null) {
        this._activeScriptItem.didSwapOutFlash(this);
      }
      this._activeScriptItem = item;
      return this._activeScriptItem.didSwapInFlash(this);
    },
    insertSwfInvisibly: function() {
      this.setSwfSize(1, 1);
      return $('body').after(this._observableSwf);
    },
    readyDidTimeout: function() {
      $('body').trigger('event_flashBlockedDetected');
      this._blocked = YES;
      this._readyTimeout = null;
      this.remove();
      this.matchSwfSizeToItem();
      this.replacePlaceHolderWithSwf();
      return this._observableSwf.bind('ready', __bind(function() {
        return this.flashBlockerDidFuckOff();
      }, this));
    },
    flashBlockerDidFuckOff: function() {
      this.setSwfSize(0, 0);
      this._observableSwf.after(this._currentPlaceHolder);
      return this._blocked = NO;
    }
  });
  ABoo.HeadlessSharedFlashObjectClassMethods = SC.Mixin.create(ABoo.SharedFlashObjectClassMethods, {
    sharedSwfForURL: function(swfURL, width, height, flashVarDict) {
      var cachedFlash;
      cachedFlash = this._cached[swfURL];
      if (!(cachedFlash != null)) {
        cachedFlash = this.create({
          _url: swfURL,
          _width: "100%",
          _height: "100%",
          _flashVarDict: flashVarDict
        });
        this._cached[swfURL] = cachedFlash;
      }
      return cachedFlash;
    }
  });
  SC.mixin(ABoo.FlashObject, ABoo.FlashObjectClassMethods);
  SC.mixin(ABoo.SharedFlashObject, ABoo.SharedFlashObjectClassMethods);
  SC.mixin(ABoo.HeadlessSharedFlashObject, ABoo.HeadlessSharedFlashObjectClassMethods);
}).call(this);


// see this for async testing
// http://benalman.com/talks/unit-testing-qunit.html#39

module( "Listener Debugger", {
  setup: function() {
    ok( true, "once extra assert per test" );
  }
});

test("test listener debugger", function() {

	var mouseDownCount=0, mouseDownCount2=0;
	this._mouseDown = function() {
		mouseDownCount++;
	}
	this._mouseDown2 = function() {
		mouseDownCount2++;
	}

	var testDiv = $("<div>");
	var _listenerDebugger = ABoo.ActiveListenerDebugger.create();
	_listenerDebugger.addListener( testDiv, 'mousedown', this, this._mouseDown );

	testDiv.trigger('mousedown');
	ok( mouseDownCount===1, "didnt get mousedown "+mouseDownCount );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this, this._mouseDown )===true, "should contain" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this, this._mouseDown )===false, "should not contain" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this, this._mouseDown2 )===false, "should not contain" );

	_listenerDebugger.addListener( testDiv, 'mousedown2', this, this._mouseDown2 );

	testDiv.trigger('mousedown2');
	ok( mouseDownCount2===1, "mousedown count is wrong! "+mouseDownCount2 );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this, this._mouseDown )===true, "yep" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this, this._mouseDown )===false, "nope" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this, this._mouseDown2 )===true, "yep" );

	_listenerDebugger.removeListener( testDiv, 'mousedown2', this, this._mouseDown2 );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this, this._mouseDown )===true, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this, this._mouseDown )===false, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this, this._mouseDown2 )===false, "!" );

	_listenerDebugger.removeListener( testDiv, 'mousedown', this, this._mouseDown );

	testDiv.trigger('mousedown');
	testDiv.trigger('mousedown2');
	ok( mouseDownCount===1, "! "+mouseDownCount );
	ok( mouseDownCount2==1, "! "+mouseDownCount2 );
});

// raises()


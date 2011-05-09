
test("test listener debugger", function() {

	var mouseDownCount=0, mouseDownCount2=0;
	this._mouseDown = function() {
		mouseDownCount++;
	}
	this._mouseDown2 = function() {
		mouseDownCount2++;
	}

	var testDiv = $("<div>");
	var _listenerDebugger = ActiveListenerDebugger.create();
	_listenerDebugger.addListener( testDiv, 'mousedown', this._mouseDown );

	testDiv.trigger('mousedown');
	ok( mouseDownCount===1, "! "+mouseDownCount );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this._mouseDown )===true, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this._mouseDown )===false, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this._mouseDown2 )===false, "!" );

	_listenerDebugger.addListener( testDiv, 'mousedown2', this._mouseDown2 );

	testDiv.trigger('mousedown2');
	ok( mouseDownCount2===1, "! "+mouseDownCount2 );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this._mouseDown )===true, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this._mouseDown )===false, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this._mouseDown2 )===true, "!" );

	_listenerDebugger.removeListener( testDiv, 'mousedown2', this._mouseDown2 );

	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown', this._mouseDown )===true, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this._mouseDown )===false, "!" );
	ok( _listenerDebugger.alreadyContain( testDiv, 'mousedown2', this._mouseDown2 )===false, "!" );

	_listenerDebugger.removeListener( testDiv, 'mousedown', this._mouseDown );

	testDiv.trigger('mousedown');
	testDiv.trigger('mousedown2');
	ok( mouseDownCount===1, "! "+mouseDownCount );
	ok( mouseDownCount2==1, "! "+mouseDownCount2 );
});


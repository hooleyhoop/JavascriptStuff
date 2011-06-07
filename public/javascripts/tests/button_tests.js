module( "Button Tests", {
  setup: function() {}
});

// Lets kick off state machine tests
test("test 3 state button", function() {

	var mockgraphics = new Mock();
	var testDiv = $("<div>");

	var mouseDownCount=0;
	this._mouseDown = function() {
		mouseDownCount++;
	}

	mockgraphics.expects(1).method('showDisabledButton');
	var threeButtonSM = ABoo.HooThreeStateItem.create( {_graphic: mockgraphics, _clickableItem$:testDiv } );

	threeButtonSM.setButtonTarget( this, this._mouseDown );
	ok( mockgraphics.verify(), "showDisabledButton not called" );

	// trigger 'ready'
	mockgraphics.expects(1).method('showMouseUp1State');
	threeButtonSM.sendEvent("ev_showState1");
	ok( mockgraphics.verify(), "showMouseUp1State not called" );

	// trigger 'down'
	mockgraphics.expects(1).method('showMouseDown1State');
	testDiv.trigger('mousedown');
	ok( mockgraphics.verify(), "showMouseDown1State not called" );

	// trigger 'out'
	var mockgraphics = new Mock();
	threeButtonSM._graphic = mockgraphics;
	mockgraphics.expects(1).method('showMouseUp1State');
	testDiv.trigger('mouseleave');
	ok( mockgraphics.verify(), "showMouseUp1State not called" );

	// trigger 'back in'
	mockgraphics.expects(1).method('showMouseDown1State');
	testDiv.trigger('mouseenter');
	ok( mockgraphics.verify(), "showMouseDown1State not called" );

	// trigger 'fire'
	// mockgraphics.expects(1).method('showMouseUp1State');
	testDiv.trigger('mouseup');
	ok( mouseDownCount===1, "Didnt fire" );

	// trigger 'disable'
	var mockgraphics = new Mock();
	threeButtonSM._graphic = mockgraphics;
	mockgraphics.expects(1).method('showDisabledButton');
	threeButtonSM.sendEvent("ev_disable");
	ok( mockgraphics.verify(), "showDisabledButton not called" );
});

test("flippy toggle thing", function() {

	var flippy = ABoo.Flippy_toggle_thing.create();
	flippy.setupDidComplete();
	ok( flippy._flippyState === false, "! "+flippy._flippyState);
	flippy.flippyFlip();
	ok( flippy._flippyState === true, "! "+flippy._flippyState);
	flippy.flippyFlip();
	ok( flippy._flippyState === false, "! "+flippy._flippyState);

	var count = 0;
	this.flippyStateDidChange = function() {
		count++;
	}

	flippy.addObserver( "_flippyState", this, 'flippyStateDidChange' );
	flippy.flippyFlip();
	ok( count===1, "Didnt Observe change" );
	flippy.removeObserver( "_flippyState", this, 'flippyStateDidChange' );

});

function mockGraphics() {
	var mockgraphics = new Mock();
	var testDiv = $("<div>");
	mockgraphics.expects(100).method('getClickableItem').returns(testDiv);
	mockgraphics.expects(100).method('showDisabledButton');
	mockgraphics.expects(100).method('showMouseUp1State');
	return mockgraphics;
}

function mockButton() {
	var jsonOb = {
		"labelStates": [ "disabled", "normal", "down" ],
		"initialState": 0,
	};

	var butt = ABoo.HooFormButtonSimple.create( {id:"a_test_button", _threeStateButtonGraphic:mockGraphics(), json: jsonOb} );
	butt.setupDidComplete();
	return butt;
}

test("create an empty button", function() {
	var jsonOb = {
		"labelStates": [ "disabled", "normal", "down" ],
		"initialState": 0,
	};
	var butt = ABoo.HooFormButtonSimple.create( {id:"a_test_button", _threeStateButtonGraphic:mockGraphics(), json: jsonOb} );
});

test("test 3 state enabledDidChange", function() {

	var butt = mockButton();

	this.fakeProp = false;
	ok( butt.currentStateName()=="st_disabled", "wrong state" );

	this.fakeProp = true;
	butt.enabledDidChange( this, "fakeProp" );
	ok( butt.currentStateName()=="st_active1", "wrong state "+butt.currentStateName() );

	butt.enabledDidChange( this, this.fakeProp );
	ok( butt.currentStateName()=="st_disabled", "wrong state" );

});

test("test 3 state form button - basic observing", function() {

	var butt = mockButton();
	var flippy = ABoo.Flippy_toggle_thing.create();
	flippy.setupDidComplete();

	var count = 0;
	this.flippyStateDidChange = function() {
		count++;
	}

	// this sends one chane - so we can set the initial state
	butt.bindToTarget( flippy, "_flippyState", this, 'flippyStateDidChange' );
		flippy.flippyFlip();
		// this sends the next change
		ok( count===2, "Didnt Observe change" );
	butt.unbindToTarget( flippy, "_flippyState", this, 'flippyStateDidChange' );
});


test("test 3 state form button - binding primitive", function() {

	var butt = mockButton();
	var flippy = ABoo.Flippy_toggle_thing.create();
	flippy.setupDidComplete();

	ok( butt.currentStateName()=="st_disabled", "wrong state" );
	butt.bindToTarget( flippy, "_flippyState", butt, 'enabledDidChange' );
		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_active1", "wrong state "+butt.currentStateName() );
		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_disabled", "wrong state" );
	butt.unbindToTarget( flippy, "_flippyState", butt, 'enabledDidChange' );
});

test("test 3 state form button - proper binding", function() {

	var butt = mockButton();
	var flippy = ABoo.Flippy_toggle_thing.create();
	flippy.setupDidComplete();
	HOO_nameSpace['snizzle123'] = flippy;

	butt.bindToKeypath( 'snizzle123', "_flippyState", 'enabledDidChange' );
		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_active1", "wrong state "+butt.currentStateName() );
		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_disabled", "wrong state" );
	butt.unbindToKeypath( 'snizzle123', "_flippyState", 'enabledDidChange' );
});

test("test 3 state form button - binding with json", function() {

	var jsonOb = {
		"bindings":
		{ "testBinding":
			{ "to_taget": "snizzle123", "to_property": "_flippyState", "do_action": "enabledDidChange" }}
	};

	var butt = mockButton();
	var flippy = ABoo.Flippy_toggle_thing.create();
	flippy.setupDidComplete();
	HOO_nameSpace['snizzle123'] = flippy;

	butt.json = jsonOb;
	var success = butt.setup_hoo_binding_from_json( "testBinding" );
		ok( success, "!" );

		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_active1", "wrong state "+butt.currentStateName() );
		flippy.flippyFlip();
		ok( butt.currentStateName()=="st_disabled", "wrong state" );
	butt.teardown_hoo_binding_from_json( "testBinding" );
});

test("add an action", function() {

	var jsonOb2 = {
		"javascriptActions":
		{ "mouseClickAction":
			{ "action_taget": "HooWindow", "action_event": "hooAlert", "action_arg": "Holy Cock", "actionIsAsync": false }}
	};

	var butt = mockButton();
	$.extend( butt.json, jsonOb2 );
	var expandedDict = butt.setup_hoo_action_from_json( "mouseClickAction" );
});

test("5 state item stuff", function() {

	var mockgraphics = new Mock();
	var testDiv = $("<div>");

	var mouseDownCount=0;
	this._mouseDown = function() {
		mouseDownCount++;
	}

	mockgraphics.expects(1).method('showDisabledButton');
	var fiveButtonSM = ABoo.HooFiveStateItem.create( {_graphic: mockgraphics, _clickableItem$:testDiv } );
	fiveButtonSM.setButtonTarget( this, this._mouseDown );
	ok( mockgraphics.verify(), "showDisabledButton not called" );
});

// Lets kick off state machine tests
test("test 3 state button", function() {

	var mockgraphics = new Mock();
	mockgraphics.expects(1).method('showDisabledButton');
	var threeButtonSM = HooThreeStateItem.create( {_graphic: mockgraphics} );
	ok( mockgraphics.verify(), "showDisabledButton not called" );

	mockgraphics.expects(1).method('showMouseUp1State');
	threeButtonSM.sendEvent("ev_showState1");
	ok( mockgraphics.verify(), "showMouseUp1State not called" );

	var mockgraphics = new Mock();
	threeButtonSM._graphic = mockgraphics;
	mockgraphics.expects(1).method('showDisabledButton');
	threeButtonSM.sendEvent("ev_disable");
	ok( mockgraphics.verify(), "showDisabledButton not called" );
});

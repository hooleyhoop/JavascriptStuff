module Presenters
	# http://0.0.0.0:3000/pages/multiple_link_buttons_test
	# Like a Button, but not a button, not part of a form, just an anchor
	class MultipleDivButtonsPagePresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global
		require 'test/unit'
		include Test::Unit::Assertions

		def initialize( controller )

			super( controller );

			singleActButton				= widgetClass('divButtonSimple');
			doubleActButton				= widgetClass('divButtonToggle');

			@window.showGrid;

			# What about if we dont want to set an explicit width?

			lambda {
				@simpleButton1 = singleActButton.new( :initailState=>1 );
				@simpleButton1.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton1.size = [105,45];
				@simpleButton1.labelStates = ['-- --', 'Do Link', 'Pressed'];
				@simpleButton1.initailState = 1;
				@simpleButton1.labelColor = '#fff';
				@simpleButton1.action = 'http://audioboo.com';
				@window.contentView.addSubView( @simpleButton1 );
			}.call

			lambda {
				@simpleButton2 = singleActButton.new( :initailState=>1 );
				@simpleButton2.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton2.size = [105,45];
				@simpleButton2.labelStates = ['-- --', 'Submit', 'Pressed'];
				@simpleButton2.initailState = 1;
				@simpleButton2.labelColor = '#fff'
				@simpleButton2.action = '#'
				# This can only do actions with no args..
				@simpleButton2.addJavascriptAction( { :mouseClick=>{ :action_taget=>'window', :action_event=>'alert', :action_arg=>'Holy Cock' }} );
				@window.contentView.addSubView( @simpleButton2 );
			}.call

			lambda {
				@largeButton2 = doubleActButton.new( :initailState=>1 );
				@largeButton2.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton2.size = [105,45];
				@largeButton2.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
				@largeButton2.initailState = 1;
				@largeButton2.labelColor = '#fff'
				@largeButton2.action = 'http://audioboo.com'
				@largeButton2.addJavascriptAction( { :mouseClick=>{ :action_taget=>'window', :action_event=>'alert', :action_arg=>'Holy Cock' }} );
				@window.contentView.addSubView( @largeButton2 );
			}.call


			lambda {
				@largeButton3 = doubleActButton.new( :initailState=>3 );
				@largeButton3.labelStates = ['-Off-', 'Go', 'Go-D', 'un Go', 'un go-D'];
				@largeButton3.size = [105,45];
				@largeButton3.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton3.labelColor = '#fff'
				@largeButton3.action = 'http://audioboo.com'
				@largeButton3.addJavascriptAction( { :mouseClick=>{ :action_taget=>'window', :action_event=>'alert', :action_arg=>'Holy Cock' }} );
				@window.contentView.addSubView( @largeButton3 );
			}.call

			# Try a dynamic resize
			lambda {
				@resizeButton1 = widgetClass('divButtonSimpleDynamicWidth').new( :initailState=>1 );
				@resizeButton1.img = '../images/buttons/simple-button/3-state-combine.png';
				@resizeButton1.size = [-1,22];
				@resizeButton1.labelStates = ['coffee monssoon gap maplin', 'coffee monssoon gap maplin', 'coffee monssoon gap maplin'];
				@resizeButton1.labelColor = '#3171d7';
				@resizeButton1.action = 'http://audioboo.com';
				@window.contentView.addSubView( @resizeButton1 );
			}.call


		end
	end
end

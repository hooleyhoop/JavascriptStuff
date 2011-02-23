module Presenters

	# Like a Button, but not a button, not part of a form, just an anchor
	class ClickableDivLinksPresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global
		require 'test/unit'
		include Test::Unit::Assertions

		def initialize( controller )

			super( controller );

			singleActButton				= widgetClass('singleActionButton');
			doubleActButton				= widgetClass('doubleActionButton');

			@window.showGrid;

			lambda {
				@simpleButton1 = singleActButton.new( :state=>1 );
				@simpleButton1.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton1.size = [105,45];
				@simpleButton1.labelStates = ['-- --', 'Do Link', 'Pressed'];
				@simpleButton1.state = 1;
				@simpleButton1.labelColor = '#fff';
				@simpleButton1.action = 'http://apple.com';
				#@simpleButton1.javascript = "alert('hello');"
				@window.contentView.addSubView( @simpleButton1 );
			}.call

			#lambda {
			#	@simpleButton2 = simpleButton.new( :state=>1 );
			#	@simpleButton2.img = '../images/buttons/simple-button/3-state-combine.png';
			#	@simpleButton2.size = [105,45];
			#	@simpleButton2.labelStates = ['-- --', 'Submit', 'Pressed'];
			#	@simpleButton2.state = 1;
			#	@simpleButton2.labelColor = '#fff'
			#	@simpleButton2.action = '/widgets/_ajaxPostTest'
			#	@window.contentView.addSubView( @simpleButton2 );
			#}.call

			#lambda {
			#	@largeButton2 = toggleButton.new( :state=>1 );
			#	@largeButton2.img = '../images/buttons/follow_button/5-state-follow-button.png';
			#	@largeButton2.size = [105,45];
			#	@largeButton2.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
			#	@largeButton2.state = 1;
			#	@largeButton2.labelColor = '#fff'
			#	@largeButton2.action = '/widgets/_ajaxPostTest'
			#	@window.contentView.addSubView( @largeButton2 );
			#}.call


			#lambda {
			#	@largeButton3 = toggleButton.new( :state=>1 );
			#	@largeButton3.labelStates = ['-Off-', 'Go', 'Go-D', 'un Go', 'un go-D'];
			#	@largeButton3.size = [105,45];
			#	@largeButton3.img = '../images/buttons/follow_button/5-state-follow-button.png';
			#	@largeButton3.state = 3;
			#	@largeButton3.labelColor = '#fff'
			#	@largeButton3.action = '/widgets/_ajaxPostTest'
			#	@window.contentView.addSubView( @largeButton3 );
			#}.call


			#lambda {
			#	@largeButton1 = toggleButton.new( :state=>1 );
			#	@largeButton1.img = '../images/buttons/follow_button/5-state-follow-button.png';
			#	@largeButton1.size = [105,45];
			#	@largeButton1.labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			#	@largeButton1.state = 0;
			#	@largeButton1.labelColor = '#fff'
			#	@largeButton1.action = '/widgets/_ajaxPostTest'
			#	@window.contentView.addSubView( @largeButton1 );
			#}.call
		end
	end
end

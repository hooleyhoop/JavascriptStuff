module Presenters
	class MultipleButtonsPagePresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global

		def initialize( controller )

			super( controller );

			colorFillClass				= widgetClass('colorFill')
			testUploadFormClass			= widgetClass('testUploadForm')
			simpleButton				= widgetClass('simpleButton')
			toggleButton				= widgetClass('toggleButton')

			@window.showGrid;

			colorFillView = colorFillClass.new();
			@window.contentView.addSubView( colorFillView );

			lambda {
				@largeButton1 = toggleButton.new();
				@largeButton1.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton1.size = [105,45];
				@largeButton1.labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
				@largeButton1.state = 0;
				@largeButton1.labelColor = '#fff'
				@largeButton1.action = '/pages/multiple_buttons_test_upload'
				@window.contentView.addSubView( @largeButton1 );
			}.call

			lambda {
				@largeButton2 = toggleButton.new();
				@largeButton2.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton2.size = [105,45];
				@largeButton2.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
				@largeButton2.state = 1;
				@largeButton2.labelColor = '#fff'
				@largeButton2.action = '/pages/multiple_buttons_test_upload'
				@window.contentView.addSubView( @largeButton2 );
			}.call

			lambda {
				@largeButton3 = toggleButton.new();
				@largeButton3.labelStates = ['-Off-', 'Go', 'Go-D', 'un Go', 'un go-D'];
				@largeButton3.size = [105,45];
				@largeButton3.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton3.state = 3;
				@largeButton3.labelColor = '#fff'
				@largeButton3.action = '/pages/multiple_buttons_test_upload'
				@window.contentView.addSubView( @largeButton3 );
			}.call


		end
	end
end

module Presenters
	# http://0.0.0.0:3000/pages/multiple_form_buttons_test
	class MultipleButtonsPagePresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global

		def initialize( controller )

			super( controller );

			colorFillClass				= widgetClass('colorFill')
			testUploadFormClass			= widgetClass('testUploadForm')
			simpleButton				= widgetClass('simpleFormButton')
			toggleButton				= widgetClass('toggleFormButton')

			@window.showGrid;

			colorFillView = colorFillClass.new();
			@window.contentView.addSubView( colorFillView );

			lambda {
				@simpleButton1 = simpleButton.new( :state=>1 );
				@simpleButton1.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton1.size = [105,45];
				@simpleButton1.labelStates = ['-- --', 'Submit', 'Pressed'];
				#@simpleButton1.state = 1;
				@simpleButton1.labelColor = '#fff'
				@simpleButton1.action = '/widgets/_ajaxPostTest'
				@simpleButton1.javascript = "this.hookupAction( function(){
					alert('Holy Cock');
				});";
				@window.contentView.addSubView( @simpleButton1 );
			}.call

			lambda {
				@simpleButton2 = simpleButton.new( :state=>1 );
				@simpleButton2.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton2.size = [105,45];
				@simpleButton2.labelStates = ['-- --', 'Submit', 'Pressed'];
				#@simpleButton2.state = 1;
				@simpleButton2.labelColor = '#fff'
				@simpleButton2.action = '/widgets/_ajaxPostTest'
				@window.contentView.addSubView( @simpleButton2 );
			}.call

			lambda {
				@largeButton2 = toggleButton.new( :state=>1 );
				@largeButton2.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton2.size = [105,45];
				@largeButton2.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
				#@largeButton2.state = 1;
				@largeButton2.labelColor = '#fff'
				@largeButton2.action = '/widgets/_ajaxPostTest'
				@window.contentView.addSubView( @largeButton2 );
			}.call

			# PRoblem here with start state!
			lambda {
				@largeButton3 = toggleButton.new( :state=>3 );
				@largeButton3.labelStates = ['-Off-', 'Go', 'Go-D', 'StartHere', 'un go-D'];
				@largeButton3.size = [105,45];
				@largeButton3.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton3.state = 3;
				@largeButton3.labelColor = '#fff'
				@largeButton3.action = '/widgets/_ajaxPostTest'
				@window.contentView.addSubView( @largeButton3 );
			}.call


			lambda {
				@largeButton1 = toggleButton.new( :state=>0 );
				@largeButton1.img = '../images/buttons/follow_button/5-state-follow-button.png';
				@largeButton1.size = [105,45];
				@largeButton1.labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
				#@largeButton1.state = 0;
				@largeButton1.labelColor = '#fff'
				@largeButton1.action = '/widgets/_ajaxPostTest'
				@window.contentView.addSubView( @largeButton1 );
			}.call

		end
	end
end

module Presenters
	class HeadlessPlayerPresenter < HooPresenter

		def initialize( controller )

			super( controller )

			headlessPlayer				= widgetClass('headlessPlayer');
			singleActButton				= widgetClass('singleActionButton');
			slider_class				= widgetClass('simpleSlider');
			spinner_class				= widgetClass('simpleBusySpinner');

			lambda {

				# OK - move these components into the player widget.
				@headlessPlayer1 = headlessPlayer.new({ :url=>'http://audioboo.fm/boos/12345.mp3'});
				#@headlessPlayer1 = headlessPlayer.new({ :url=>'/boos/test2.mp3'});
				#@headlessPlayer1 = headlessPlayer.new({ :url=>'http://boos.audioboo.fm/attachments/961541/Recording.mp3?audio_clip_id=289899'});
				#@headlessPlayer1 = headlessPlayer.new({ :url=>'http://0.0.0.0:3000/boos/test2.mp3?'})
				@window.contentView.addSubView( @headlessPlayer1 );
			}.call


			# Add a simple clickable button

			# bind button enabled to palyer.ready();
			# if javascript is disabled state must be 1
			# so initial state must be 1

			lambda {
				@simpleButton2 = singleActButton.new( :state=>1 );
				@simpleButton2.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton2.size = [105,45];
				@simpleButton2.labelStates = ['-- --', 'Submit', 'Pressed'];
				@simpleButton2.state = 1;
				@simpleButton2.labelColor = '#fff'
				@simpleButton2.action = '#'

				# old way
				#@simpleButton2.javascript = "this.hookupAction( function(){
				#	alert('Holy Cock');
				#});";

				headlessPlayer1InstanceName = @headlessPlayer1.varName;
				@simpleButton2.addBinding( { :enabled=>{ :enabled_taget=>headlessPlayer1InstanceName, :enabled_property=>'ready' } } );
				@simpleButton2.addJavascriptAction( { :mouseClick=>{ :action_taget=>headlessPlayer1InstanceName, :action_event=>'play' }} );

				@window.contentView.addSubView( @simpleButton2 );
			}.call

			# A simple slider
			lambda {
				@simpleSlider = slider_class.new();
				@window.contentView.addSubView( @simpleSlider );
			}.call


			# A simple spinner
			lambda {
				@simpleSpinner = spinner_class.new();
				@window.contentView.addSubView( @simpleSpinner );

				# Spinners and progress need to be bound to the player instance, not the singleton

				#-- how can we only bind the active player?

				#@simpleButton2.addBinding( { :enabled=>{ :enabled_taget=>headlessPlayer1InstanceName, :enabled_property=>'ready' } } );
			}.call

			lambda {
			#	@headlessPlayer2 = headlessPlayer.new({ :url=>'http://0.0.0.0:3000/audio/test.mp3'});
			#	@window.contentView.addSubView( @headlessPlayer2 );
			}.call

			#play pause button
			#time slider

			#@player = widgetClass('detailPlayer').new();
			#@window.contentView.addSubView( @player );

			#@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			#@window.contentView.addSubView( @spacer );

			#@adam_player = widgetClass('adam_detailPlayer').new();
			#@window.contentView.addSubView( @adam_player );

			#@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			#@window.contentView.addSubView( @spacer );

		end



	end
end

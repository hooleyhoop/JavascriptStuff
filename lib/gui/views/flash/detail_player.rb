module Gui::Views::Flash

	# http://0.0.0.0:3000/widgets/detailPlayer?url=http://boos.audioboo.fm/attachments/733544/Recording.mp3?audio_clip_id=213134
	class DetailPlayer < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		attr_accessor :playerLeft, :playerRight, :playerMid, :playButton, :carat;
		attr_accessor :playerLeft2, :playerRight2, :playerMid2

		def initialize( args={} )
			super(args);

			@playerLeft		= '../images/player/player-left-cap.png';
			@playerMid		= '../images/player/player-mid.png';
			@playerRight	= '../images/player/player-right-cap.png';

			@playerLeft2	= '../images/player/player-left-cap2.png';
			@playerMid2		= '../images/player/player-mid2.png';
			@playerRight2	= '../images/player/player-right-cap2.png';

			@playButton		= '../images/player/play-button.png';
			@carat			= '../images/player/carat.png';

			headlessPlayer				= widgetClass('headlessPlayer');
			singleActButton				= widgetClass('divButtonSimple');
			toggleActButton				= widgetClass('divButtonToggle');
			slider_class				= widgetClass('simpleSlider');
			spinner_class				= widgetClass('simpleBusySpinner');
			simpleTextFieldClass		= widgetClass('simpleTextField');



			lambda {
				# OK - move these components into the player widget.
				@headlessPlayer1 = headlessPlayer.new({ :url=>args[:url] });

				#@headlessPlayer1 = headlessPlayer.new({ :url=>'/boos/test2.mp3'});
				#@headlessPlayer1 = headlessPlayer.new({ :url=>'http://boos.audioboo.fm/attachments/961541/Recording.mp3?audio_clip_id=289899'});
				#@headlessPlayer1 = headlessPlayer.new({ :url=>'http://0.0.0.0:3000/boos/test2.mp3?'})
				addSubView( @headlessPlayer1 );
			}.call
			headlessPlayer1InstanceName = @headlessPlayer1.varName;


			# Add a simple clickable button

			# bind button enabled to palyer.ready();
			# if javascript is disabled state must be 1
			# so initial state must be 1

			# We cant have reset and error bindings on a button, there must be a detail_player controller responsible for these things
			lambda {
				playButton = toggleActButton.new( :initialState=>1 );
				playButton.img = '../images/player/detail_player_play_button.png';
				playButton.size = [15*5,15*5];
				playButton.labelStates = ['-Off-', 'Play', 'Do It-D', 'Pause', 'UnDoIt-D'];
				playButton.initialState = 1;
				playButton.labelColor = '#fff'
				playButton.action = 'http://audioboo.com'

				# old way
				#playButton.javascript = "this.hookupAction( function(){
				#	alert('Holy Cock');
				#});";

				#// DO WE REALLY REALLY WANT TO DO THIS HERE?
				playButton.addBinding( { :enabledBinding=>{ :to_taget=>headlessPlayer1InstanceName, :to_property=>'ready', :do_action=>'readyDidChange' } } );
				playButton.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>headlessPlayer1InstanceName, :action_event=>'play', :actionIsAsync=>true  }} );

				addSubView( playButton );
			}.call

			# Duration
			#temp lambda {
			#temp 	@durationTextField = simpleTextFieldClass.new( {:prefix=>'Duration ',:text=>'0',:postfix=>' seconds'} );
			#temp 	@durationTextField.addBinding( { :textBinding=>{ :to_taget=>headlessPlayer1InstanceName, :to_property=>'duration', :do_action=>'_textDidChange' } } );
			#temp 	addSubView( @durationTextField );
			#temp }.call

			# Loaded Seconds
			#temp lambda {
			#temp 	@loadedSecondsTextField = simpleTextFieldClass.new( {:prefix=>'Loaded ',:text=>'0',:postfix=>' seconds'} );
			#temp 	@loadedSecondsTextField.addBinding( { :textBinding=>{ :to_taget=>headlessPlayer1InstanceName, :to_property=>'loadedSeconds', :do_action=>'_textDidChange' } } );
			#temp 	addSubView( @loadedSecondsTextField );
			#temp }.call

			# Current Seconds
			#temp lambda {
			#temp 	@positionSecondsTextField = simpleTextFieldClass.new( {:prefix=>'Position ',:text=>'0',:postfix=>' seconds'} );
			#temp 	@positionSecondsTextField.addBinding( { :textBinding=>{ :to_taget=>headlessPlayer1InstanceName, :to_property=>'playPosition', :do_action=>'_textDidChange' } } );
			#temp 	addSubView( @positionSecondsTextField );
			#temp }.call

			# A simple slider
			#temp lambda {
			#temp 	@simpleSlider = slider_class.new();
			#temp 	addSubView( @simpleSlider );
			#temp }.call


			# A simple spinner
			#lambda {
			#	@simpleSpinner = spinner_class.new();
			#	addSubView( @simpleSpinner );

				# Spinners and progress need to be bound to the player instance, not the singleton

				#-- how can we only bind the active player?

			#	#playButton.addBinding( { :enabled=>{ :enabled_taget=>headlessPlayer1InstanceName, :enabled_property=>'ready' } } );
			#}.call



		end

		# Mock Data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties

			# TODO! got to find a better way todo this!
			self.addRuntimeObject({:_headlessAudioPlayer => @headlessPlayer1.varName });

			allItems = {
			}

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects.nil?
			return allItems

		end


	end
end

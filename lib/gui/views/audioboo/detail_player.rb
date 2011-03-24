module GUI::Views::Audioboo

	# http://0.0.0.0:3000/widgets/detailPlayer
	class DetailPlayer < GUI::Core::HooView

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

			headlessPlayer				= GUI::HooWidgetList.widgetClass('headlessPlayer');
			singleActButton				= GUI::HooWidgetList.widgetClass('divButtonSimple');
			slider_class				= GUI::HooWidgetList.widgetClass('simpleSlider');
			spinner_class				= GUI::HooWidgetList.widgetClass('simpleBusySpinner');
			simpleTextFieldClass		= GUI::HooWidgetList.widgetClass('simpleTextField');

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

			lambda {
				@simpleButton2 = singleActButton.new( :initialState=>1 );
				@simpleButton2.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton2.size = [105,45];
				@simpleButton2.labelStates = ['', 'Play', 'Play'];
				@simpleButton2.initialState = 1;
				@simpleButton2.labelColor = '#fff'
				@simpleButton2.action = '#'

				# old way
				#@simpleButton2.javascript = "this.hookupAction( function(){
				#	alert('Holy Cock');
				#});";

				@simpleButton2.addBinding( { :enabledBinding=>{ :enabled_taget=>headlessPlayer1InstanceName, :enabled_property=>'ready' } } );
				@simpleButton2.addJavascriptAction( { :mouseClick=>{ :action_taget=>headlessPlayer1InstanceName, :action_event=>'play' }} );

				addSubView( @simpleButton2 );
			}.call

			# Duration
			lambda {
				@durationTextField = simpleTextFieldClass.new( {:prefix=>'Duration ',:text=>'0',:postfix=>' seconds'} );
				@durationTextField.addBinding( { :textBinding=>{ :text_taget=>headlessPlayer1InstanceName, :text_property=>'duration' } } );
				addSubView( @durationTextField );
			}.call

			# Loaded Seconds
			lambda {
				@loadedSecondsTextField = simpleTextFieldClass.new( {:prefix=>'Loaded ',:text=>'0',:postfix=>' seconds'} );
				@loadedSecondsTextField.addBinding( { :textBinding=>{ :text_taget=>headlessPlayer1InstanceName, :text_property=>'loadedSeconds' } } );
				addSubView( @loadedSecondsTextField );
			}.call

			# Current Seconds
			lambda {
				@positionSecondsTextField = simpleTextFieldClass.new( {:prefix=>'Position ',:text=>'0',:postfix=>' seconds'} );
				@positionSecondsTextField.addBinding( { :textBinding=>{ :text_taget=>headlessPlayer1InstanceName, :text_property=>'playPosition' } } );
				addSubView( @positionSecondsTextField );
			}.call

			# A simple slider
			lambda {
				@simpleSlider = slider_class.new();
				addSubView( @simpleSlider );
			}.call


			# A simple spinner
			#lambda {
			#	@simpleSpinner = spinner_class.new();
			#	addSubView( @simpleSpinner );

				# Spinners and progress need to be bound to the player instance, not the singleton

				#-- how can we only bind the active player?

			#	#@simpleButton2.addBinding( { :enabled=>{ :enabled_taget=>headlessPlayer1InstanceName, :enabled_property=>'ready' } } );
			#}.call



		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

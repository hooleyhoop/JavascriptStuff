module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooSmallPlayerPlayButton
	class HooSmallPlayerPlayButton < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		#attr_accessor :parentCanvas

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

            # playPauseButton needs a canvas
            @parentCanvas = widgetClass('HooCanvas').new();
    	    addSubView( @parentCanvas );

			# Radial Progress Indicator
            @radialProgress = widgetClass('HooRadialProgress').new( {:parentCanvas=>@parentCanvas, :outerRad=>1.0, :innerRad=>0.75} );
    	    addSubView( @radialProgress );

			# Play / Pause Button
	        @playPauseButton = widgetClass('HooPlayPauseButton').new( {:parentCanvas=>@parentCanvas, :percentOfCanvas=>0.7} );
    	    addSubView( @playPauseButton );

			@playPauseButton.action = 'http://audioboo.fm';
			@playPauseButton.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooLog', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );

			#DEBUG STUFF
    	    @chckbx1 = widgetClass('HooSimpleCheckbox').new( {:label=>'show busy'} );
    	    addSubView( @chckbx1 );
			@chckbx1.addJavascriptAction( { :mouseClickAction=>{ :action_taget=> @radialProgress.varName, :action_event=>'toggleBusy', :action_arg=>nil, :actionIsAsync=>false  }} );

    		@txtfield1 = widgetClass('HooDebugTextInput').new( {:label=>'loadProgress', :value=>'100'} );
			@txtfield1.addJavascriptAction( { :mouseClickAction=>{ :action_taget=> @radialProgress.varName, :action_event=>'setLoadProgress', :action_arg=>nil, :actionIsAsync=>false  }} );
    	    addSubView( @txtfield1 );

    	   	@txtfield2 = widgetClass('HooDebugTextInput').new( {:label=>'playprogress', :value=>'130'} );
			@txtfield2.addJavascriptAction( { :mouseClickAction=>{ :action_taget=> @radialProgress.varName, :action_event=>'setPlayProgress', :action_arg=>nil, :actionIsAsync=>false  }} );
    	    addSubView( @txtfield2 );
		end

		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_radialProgress => @radialProgress.varName });
			self.addRuntimeObject({:_playPauseButton => @playPauseButton.varName });

			allItems = {
			}

			#TODO: This is all fucked! wshy do i have to duplicate this everywhere? Easy to sort out
			# - get custom items
			# - conditionally merge bindings
			# - conditionally merge actions
			# - seperate out items that require swapping at runtime

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects.nil?
			return allItems

		end

	end
end

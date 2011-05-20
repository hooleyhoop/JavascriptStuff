module GUI::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/smallPlayerPlayButton
	class HooSmallPlayerPlayButton < GUI::Core::HooView

		#attr_accessor :parentCanvas

		def initialize( args={} )
			super(args);
		end

		def addRuntimeObject( aHash )
			if(@runtimeObjects==nil)
				@runtimeObjects = {};
			end
			@runtimeObjects.merge!( aHash );
		end

        # Mock Data
		def setupDebugFixture
			super();

            # playPauseButton needs a canvas
            @parentCanvas = GUI::HooWidgetList.widgetClass('canvas').new();
    	    addSubView( @parentCanvas );

	        @playPauseButton = GUI::HooWidgetList.widgetClass('playPauseButton').new( {:parentCanvas=>@parentCanvas} );
    	    addSubView( @playPauseButton );

			@playPauseButton.action = 'http://audioboo.fm';
			@playPauseButton.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooLog', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );

            @radialProgress = GUI::HooWidgetList.widgetClass('radialProgress').new( {:parentCanvas=>@parentCanvas} );
    	    addSubView( @radialProgress );


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

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects==nil;

		end

	end
end

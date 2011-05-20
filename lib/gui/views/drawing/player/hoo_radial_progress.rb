module GUI::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/radialProgress
	class HooRadialProgress <  GUI::Core::HooView

		attr_accessor :parentCanvas

		def initialize( args={} )
			super(args);
			extractArgs( args, {:parentCanvas=>nil} );
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
		end

		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });

			allItems = {
				:initialState		=> @initialState,
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

module GUI::Views::Debug::CroppedImage

    # http://0.0.0.0:3000/widgets/canvasimgresizetest

	class CanvasImgResizeTest < GUI::Core::HooView

		include GUI::Core::HooBindingsMixin

		attr_accessor :parentCanvas
		attr_accessor :imgUrl;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:parentCanvas=>nil, :imgUrl=>'http://farm2.static.flickr.com/1013/887300612_044d2e38ed.jpg'} );
		end

        # Mock Data
		def setupDebugFixture
			super();

            # CanvasImgResizeTest needs a canvas
            @parentCanvas = GUI::HooWidgetList.widgetClass('canvas').new();
    	    addSubView( @parentCanvas );

		end

		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });
			allItems = {
				:imgUrl => @imgUrl
			}
			#TODO: This is all fucked! wshy do i have to duplicate this everywhere? Easy to sort out
			# - get custom items
			# - conditionally merge bindings
			# - conditionally merge actions
			# - seperate out items that require swapping at runtime
			allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;
			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects==nil;
		end

	end
end
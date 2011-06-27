module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooRadialProgress
	# http://0.0.0.0:3000/widgets/HooRadialProgress?outerRad=0.99&innerRad=0.8
	class HooRadialProgress <  Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		attr_accessor :parentCanvas
		attr_accessor :outerRad
		attr_accessor :innerRad

		def initialize( args={} )
			super(args);
			extractArgs( args, {:parentCanvas=>nil, :outerRad=>1.0, :innerRad=>0.5} );
		end

        # Mock Data
		def setupDebugFixture
			super();

			# playPauseButton needs a canvas
			@parentCanvas = widgetClass('HooCanvas').new();
			addSubView( @parentCanvas );

			@chckbx1 = widgetClass('HooSimpleCheckbox').new( {:label=>'show busy'} );
			addSubView( @chckbx1 );
			@chckbx1.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>nil, :actionIsAsync=>false  }} );

			@txtfield1 = widgetClass('HooDebugTextInput').new( {:label=>'loadProgress', :value=>'100'} );
			@txtfield1.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'setLoadProgress', :action_arg=>nil, :actionIsAsync=>false  }} );
			addSubView( @txtfield1 );

			@txtfield2 = widgetClass('HooDebugTextInput').new( {:label=>'playprogress', :value=>'130'} );
			@txtfield2.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'setPlayProgress', :action_arg=>nil, :actionIsAsync=>false  }} );
			addSubView( @txtfield2 );
		end


		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });

			allItems = {
				:outerRad => @outerRad,
				:innerRad => @innerRad
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

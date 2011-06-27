module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooPlayPauseButton
	class HooPlayPauseButton < Gui::Views::Drawing::Buttons::DivButton::HooDivButtonAbstract

		include Gui::Core::HooBindingsMixin

		attr_accessor :parentCanvas
		attr_accessor :percentOfCanvas

		def initialize( args={} )
			@_states = 5
			extractArgs( args, {:parentCanvas=>nil, :percentOfCanvas=>0.6} );
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

            # playPauseButton needs a canvas
            @parentCanvas = widgetClass('HooCanvas').new();
    	    addSubView( @parentCanvas );

			@action = 'http://audioboo.fm';
			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooLog', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );

		end

		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });

			allItems = {
				:initialState => @initialState,
				:percentOfCanvas => @percentOfCanvas
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

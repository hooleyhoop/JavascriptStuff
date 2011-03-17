module GUI::Views::Drawing::Buttons

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/divButtonSimple
	# http://0.0.0.0:3000/widgets/divButtonSimple?initialState=1
	class HooDivButtonSimple < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :initialState;
		attr_accessor :labelColor;

		# the button action (no javascript) and the javacript action it will be replaced with
		attr_accessor :action;
		attr_accessor :bindings;
		attr_accessor :javascriptActions;

		def initialize( args={} )
			super(args);
			if args[:initialState]
				@initialState=args[:initialState].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
			@size = [105, 45];
			@initialState=0 if @initialState==nil
			@labelColor = '#eee';
			@action = 'http://apple.com';
			self.addJavascriptAction( { :mouseClick=>{ :action_taget=>'window', :action_event=>'alert', :action_arg=>'Holy Cock' }} );
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==3, 'you need to have 3 states' );
		end

		def addBinding( aHash )
			if(@bindings==nil)
				@bindings = {};
			end
			@bindings.merge!( aHash );
		end

#TODO: Still got to work out the bindings superclass

		def addJavascriptAction( aHash )
			if(@javascriptActions==nil)
				@javascriptActions = {};
			end
			@javascriptActions.merge!( aHash );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates		=> @labelStates,
				:initialState		=> @initialState,
				:size				=> @size,
			}
			allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;
			return allItems.to_json();
		end

	end
end

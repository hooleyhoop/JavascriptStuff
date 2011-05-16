module GUI::Views::Drawing::Buttons::DivButton

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	class HooDivButtonAbstract < GUI::Core::HooView

		include GUI::Core::HooBindingsMixin

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
			extractArgs( args, {:initialState=>0} );
		end

        # Mock Data
		def setupDebugFixture
			super();
			@size = [105, 45];
			@initialState=0 if @initialState==nil
			@labelColor = '#eee';
			@action = '/widgets/_ajaxPostTest';
			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'window', :action_event=>'alert', :action_arg=>'Holy Cock', :actionIsAsync=>false }} );
		end

		def labelStates=(states)
			# pad out if we only set 1 value.. pad out to 3 or 5 ?
			if(states.count!=@_states)
				states.fill('--machine added--', states.count..@_states) # => ["b", "c", "a", "a"]
			end
			@labelStates = states;
			assert( @labelStates.count==@_states, "you need to have #{@_states} states" );
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

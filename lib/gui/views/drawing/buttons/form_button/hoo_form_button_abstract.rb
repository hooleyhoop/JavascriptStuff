require 'test/unit'

module Gui::Views::Drawing::Buttons::FormButton

	class HooFormButtonAbstract < Gui::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :initialState;
		attr_accessor :labelColor;

		# the button action (no javascript) and the javacript action it will be replaced with
		attr_accessor :action;

		include Gui::Core::HooBindingsMixin

		def initialize( args={} )
			super(args);
			if args[:initialState]
				@initialState=args[:initialState].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super()

			@labelStates = ['Disabled', 'Ready', 'Pressed']
			@img = '../images/buttons/simple-button/3-state-combine.png'
			@size = [105, 45]
			@initialState ||=0
			@labelColor = '#eee'
			@action = '/widgets/_ajaxPostTest'
			#@javascript = "this.hookupAction( function(){
			#	alert('Holy Cock');
			#});";
		end

		def labelStates=(states)

			# pad out if we only set 1 value.. pad out to 3 or 5 ?
			if( states.count != @_states )
				states.fill('--machine added--', states.count..@_states) # => ["b", "c", "a", "a"]
			end
			@labelStates = states;
			assert( @labelStates.count==@_states, "you need to have #{@_states} states" );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:initialState	=> @initialState,
				:size			=> @size
				#:javascript		=> @javascript,
			}
			allItems.merge!( { :bindings => @bindings } ) unless @bindings.nil?
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions.nil?
			return allItems
		end

	end
end

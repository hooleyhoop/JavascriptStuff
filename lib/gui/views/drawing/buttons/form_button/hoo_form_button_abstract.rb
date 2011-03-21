module GUI::Views::Drawing::Buttons::FormButton

	class HooFormButtonAbstract < GUI::Core::HooView

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :initialState;
		attr_accessor :labelColor;

		# the button action (no javascript) and the javacript action it will be replaced with
		attr_accessor :action;
		attr_accessor :javascript;

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
			@action = '/widgets/_ajaxPostTest';
			@javascript = "this.hookupAction( function(){
				alert('Holy Cock');
			});";
		end

		def labelStates=(states)
			@labelStates = states;

			-- pad out if it comes up short.. to 3 or five?

			-- get rid of this --
			assert( states.count==3, 'you need to have 3 states for the button' );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:initialState	=> @initialState,
				:size			=> @size,
				:javascript		=> @javascript,
			}
			return allItems.to_json();
		end

	end
end
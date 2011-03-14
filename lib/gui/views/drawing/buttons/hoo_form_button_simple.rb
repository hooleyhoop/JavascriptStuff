module GUI::Views::Drawing::Buttons

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/formButtonSimple
	# http://0.0.0.0:3000/widgets/formButtonSimple?state=1
	class HooFormButtonSimple < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :initailState;
		attr_accessor :labelColor;

		# the button action (no javascript) and the javacript action it will be replaced with
		attr_accessor :action;
		attr_accessor :javascript;

		def initialize( args={} )
			super();
			if args[:initailState]
				@initailState=args[:initailState].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
			@size = [105, 45];
			@initailState=0 if @initailState==nil
			@labelColor = '#eee';
			@action = '/widgets/_ajaxPostTest';
			@javascript = "this.hookupAction( function(){
				alert('Holy Cock');
			});";
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==3, 'you need to have 3 states for the button' );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:initailState	=> @initailState,
				:size			=> @size,
				:javascript		=> @javascript,
			}
			return allItems.to_json();
		end

	end
end

module GUI::Views::Drawing

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/simpleButton
	# http://0.0.0.0:3000/widgets/simpleButton?state=1
	class HooSimpleButton < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :state;
		attr_accessor :labelColor;
		attr_accessor :action;

		def initialize( args={} )
			super();
			if args['state']
				@state = args['state'].to_i
			end
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
			@size = [105, 45];

			if @state == nil
				@state = 0;
			end

			@labelColor = '#969696'
			@action = ''
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==3 );
		end

		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:state			=> @state,
				:size			=> @size,
			}
			return allItems.to_json();
		end

	end
end

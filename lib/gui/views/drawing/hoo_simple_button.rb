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
			@state=args['state'].to_i() if args['state']
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
			@size = [105, 45];
			@state=0 if @state==nil
			@labelColor = '#eee';
			@action = '/widgets/_ajaxPostTest';
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==3 );
		end

		# stuff to write into the page
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

module GUI::Views::Drawing::Buttons

	# 5 state Toggle button
	# 0) Disabled 1)state1 2)state1Pressed 3)state2 4)state2Pessed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/formButtonToggle
	# http://0.0.0.0:3000/widgets/formButtonToggle?state=1
	class HooFormButtonToggle < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :initailState;
		attr_accessor :labelColor;
		attr_accessor :action;

		def initialize( args={} )
			super();
			if args[:initailState]
				@initailState=args[:initailState].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/follow_button/5-state-follow-button.png';
			@size = [105, 45];
			@initailState=0 if @initailState==nil
			@labelColor = '#eee';
			@action = '#'; # /widgets/_ajaxPostTest
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==5, 'you need to have 5 label states, you have '+states.count.to_s );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:initailState	=> @initailState,
				:size			=> @size,
			}
			return allItems.to_json();
		end

	end
end

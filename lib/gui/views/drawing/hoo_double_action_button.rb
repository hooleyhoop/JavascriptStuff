module GUI::Views::Drawing

	# 5 state Toggle button
	# 0) Disabled 1)state1 2)state1Pressed 3)state2 4)state2Pessed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/doubleActionButton
	# http://0.0.0.0:3000/widgets/doubleActionButton?state=1
	class HooDoubleActionButton < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :state;
		attr_accessor :labelColor;
		attr_accessor :action;

		def initialize( args={} )
			super();
			@state = args['state'].to_i() if args['state']
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/follow_button/5-state-follow-button.png';
			@size = [105, 45];
			@state=0 if @state==nil
			@labelColor = '#eee';
			@action = 'http://apple.com';
			@javascript = "this.hookupAction( function(){
				alert('Holy Smuck');
			});";
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==5 );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:labelStates	=> @labelStates,
				:state			=> @state,
				:size			=> @size,
				:javascript		=> @javascript,
			}
			return allItems.to_json();
		end

	end
end

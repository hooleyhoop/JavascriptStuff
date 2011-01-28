module GUI::Views::Drawing

	# 5 state Toggle button
	# 0) Disabled 1)state1 2)state1Pressed 3)state2 4)state2Pessed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/toggleButton
	class HooToggleButton < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;
		attr_accessor :size;
		attr_accessor :labelStates
		attr_accessor :state;
		attr_accessor :labelColor;
		attr_accessor :action;

		def initialize( args={} )
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();

			@states = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/follow_button/5-state-follow-button.png';
			@size = [105, 45];
			@state = 0;

			@labelColor = '#969696'
			@action = ''
		end

		def labelStates=(states)
			@labelStates = states;
			assert( states.count==5 );
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


# Have to run when loaded by ajax
# self.window.installStartupJavascript( :function=>"crippleListView", :arg1=>@textList.uniqueSelector(), :arg2=>@widgetResizer.actionName );

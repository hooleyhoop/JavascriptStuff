module Gui::Views::Drawing::Buttons::FormButton

	# 5 state Toggle button
	# 0) Disabled 1)state1 2)state1Pressed 3)state2 4)state2Pessed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/HooFormButtonToggle
	# http://0.0.0.0:3000/widgets/HooFormButtonToggle?initialState=1
	class HooFormButtonToggle < HooFormButtonAbstract

		def initialize( args={} )
			@_states = 5
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/follow_button/5-state-follow-button.png';
			@size = [105, 45];
			@initialState=0 if @initialState==nil
			@labelColor = '#eee';
			@action = '#'; # /widgets/_ajaxPostTest
		end




	end
end

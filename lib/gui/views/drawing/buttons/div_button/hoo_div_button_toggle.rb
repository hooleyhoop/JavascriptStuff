module Gui::Views::Drawing::Buttons::DivButton

	# 5 state Toggle button
	# 0) Disabled 1)state1 2)state1Pressed 3)state2 4)state2Pessed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/divButtonToggle
	# http://0.0.0.0:3000/widgets/divButtonToggle?initialState=1
	class HooDivButtonToggle < HooDivButtonAbstract

		# ! yay we dont really need this! except of course they render different partials

		def initialize( args={} )
			@_states = 5
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
			@labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/follow_button/5-state-follow-button.png';
		end

	end
end

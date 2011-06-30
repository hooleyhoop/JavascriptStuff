module Gui::Views::Drawing::Buttons::DivButton

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/HooDivButtonSimple
	# http://0.0.0.0:3000/widgets/HooDivButtonSimple?initialState=1
	class HooDivButtonSimple < HooDivButtonAbstract

		# ! yay we dont really need this! except of course they render different partials

		def initialize( args={} )
			@_states = 3
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
		end

	end
end

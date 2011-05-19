module GUI::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/playPauseButton
	class HooPlayPauseButton <  GUI::Views::Drawing::Buttons::DivButton::HooDivButtonAbstract

		def initialize( args={} )
			@_states = 5
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

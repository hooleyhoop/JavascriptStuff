module GUI::Views

    # Draw a div with a background img at fixed size
	class HooBackgroundImg < GUI::Core::HooView

        attr_accessor :img;

		def initialize
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/innerpanel/inner_panel_speech_right.png';
			@width = 90;
			@height = 90;
		end

	end
end

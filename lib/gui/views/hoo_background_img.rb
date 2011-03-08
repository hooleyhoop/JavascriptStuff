module GUI::Views

	# http://0.0.0.0:3000/widgets/backgroundImage

    # Draw a div with a background img at fixed size
	class HooBackgroundImg < GUI::Core::HooView

        attr_accessor :img;
        attr_accessor :customCSSAttributes;	# This might be a useful thing to add elsewhere, lets see

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/innerpanel/inner_panel_speech_right.png';
			@width = 90;
			@height = 90;
			@customCSSAttributes = { opacity:0.8 };
		end

	end
end

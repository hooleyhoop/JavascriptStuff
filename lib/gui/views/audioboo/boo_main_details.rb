module GUI::Views::Audioboo

	# http://0.0.0.0:3000/widgets/booMainDetails
	class BooMainDetails < GUI::Core::HooView

        attr_accessor :img;
        attr_accessor :width, :height;

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/innerpanel/inner_panel_speech_right.png';
			@width = 90;
			@height = 90;
		end

	end
end

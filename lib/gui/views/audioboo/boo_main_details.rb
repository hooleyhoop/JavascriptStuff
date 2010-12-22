module GUI::Views::Audioboo

	class BooMainDetails < GUI::Core::HooView

        attr_accessor :img;
        attr_accessor :width, :height;

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

module GUI::Views::Unsorted

    # Please fill me in
	class HooCroppedImg < GUI::Core::HooView

        attr_accessor :path;

		def initialize
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@path = '../images/innerpanel/inner_panel_speech_right.png';

		end


	end
end

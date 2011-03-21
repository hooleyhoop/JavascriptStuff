module GUI::Views::Unsorted

    # http://0.0.0.0:3000/widgets/croppedImg
	class HooCroppedImg < GUI::Core::HooView

        attr_accessor :path;

        # Mock Data
		def setupDebugFixture
			super();
			@path = '../images/innerpanel/inner_panel_speech_right.png';
		end


	end
end

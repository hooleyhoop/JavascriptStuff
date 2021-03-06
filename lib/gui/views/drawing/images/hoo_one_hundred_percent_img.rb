module Gui::Views::Drawing::Images

    # http://0.0.0.0:3000/widgets/HooOneHundredPercentImg
	class HooOneHundredPercentImg < Gui::Core::HooView

        attr_accessor :img;
        attr_accessor :label, :labelLink;

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/innerpanel/inner_panel_speech_right.png';
			@label = 'map'
			@labelLink = 'www.apple.com'
			@width = 90;
			@height = 90;
		end


	end
end

module GUI::Views::Drawing::Images

    # http://0.0.0.0:3000/widgets/croppedImg
	class HooCroppedImg < GUI::Core::HooView

        attr_accessor :path;

        # Mock Data
		def setupDebugFixture
			super();
			@path = '../images/boo/sampleImage1.jpg';
		end


	end
end
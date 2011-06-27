module Gui::Views::Debug::CroppedImage

    # http://0.0.0.0:3000/widgets/FlashResizeTest

	class FlashResizeTest < Gui::Core::HooView

		attr_accessor :flashUrl;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:flashUrl=>'/flash/ImgResizer/ImgResizer.swf'} );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

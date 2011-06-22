module Gui::Views::Debug::MovingASharedFlash

    # http://0.0.0.0:3000/widgets/flashsharedelement

	# The purpose of this is ONLY to be used by FlashSharedElementTest
	class FlashSharedElement < Gui::Core::HooView

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

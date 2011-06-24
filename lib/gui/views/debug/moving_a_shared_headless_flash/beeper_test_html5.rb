module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/BeeperTestHtml5

	class BeeperTestHtml5 < Gui::Core::HooView

		attr_accessor :mp3Url;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:mp3Url=>'http://audioboo.fm/boos/393446-converting-arr-to-mp3-for-an-audioboo.mp3'} );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

		def jsonProperties
			allItems = {
				:mp3Url => @mp3Url
			}
		end

	end
end

module GUI::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/beepertesthtml5

	class BeeperTestHTML5 < GUI::Core::HooView

		attr_accessor :mp3Url;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:mp3Url=>'http://audioboo.fm/boos/305019-taking-frank-to-the-vet.mp3'} );
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

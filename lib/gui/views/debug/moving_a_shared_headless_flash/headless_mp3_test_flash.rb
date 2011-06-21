module GUI::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/headless_mp3_test_flash

	class HeadlessMp3TestFlash < GUI::Core::HooView

		# inherited
		#self.included(base) do
			#GUI::HooWidgetList << self
		#end

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

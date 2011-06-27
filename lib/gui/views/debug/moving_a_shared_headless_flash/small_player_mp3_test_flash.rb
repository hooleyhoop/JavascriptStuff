module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://shooley.audioboo.fm:3000/widgets/SmallPlayerMp3TestFlash

	class SmallPlayerMp3TestFlash < Gui::Core::HooView

		# inherited
		#self.included(base) do
			#Gui::HooWidgetList << self
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

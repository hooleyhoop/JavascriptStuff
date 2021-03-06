module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://shooley.audioboo.fm:3000/widgets/HeadlessHtml5Mp3Test

	class HeadlessHtml5Mp3Test < Gui::Core::HooView

		# inherited
		#self.included(base) do
			#Gui::HooWidgetList << self
		#end

		attr_accessor :mp3Url;

		def initialize( args={} )
			super(args);

			#TODO! i reallly need a global list of boourls!
			# fireman rich = http://audioboo.fm/boos/393446-converting-arr-to-mp3-for-an-audioboo.mp3
			extractArgs( args, {:mp3Url=>'http://audioboo.fm/boos/406609-test.mp3'} );
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

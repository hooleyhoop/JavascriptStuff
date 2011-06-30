module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooDynamicSmallPlayerPlayButton
	class HooDynamicSmallPlayerPlayButton < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

		#def jsonProperties
		#end

	end
end

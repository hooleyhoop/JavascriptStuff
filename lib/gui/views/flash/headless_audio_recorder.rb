module Gui::Views::Flash

	# http://0.0.0.0:3000/widgets/headlessRecorder
	class HeadlessAudioRecorder < Gui::Core::HooView

		def initialize( args={} )
			super(args);
		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

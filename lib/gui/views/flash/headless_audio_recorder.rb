module GUI::Views::Flash

	class HeadlessAudioRecorder < GUI::Core::HooView

		def initialize( args={} )
			super(args);
		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

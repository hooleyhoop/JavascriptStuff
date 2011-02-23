module GUI::Views::Flash

	class HeadlessAudioPlayer < GUI::Core::HooView

		attr_accessor :mp3Url;

		def initialize( args={} )
			super();
			@mp3Url = '';
			if args[:url]
				@mp3Url=args[:url];
			end
		end

		# Mock Data
		def setupDebugFixture
			super();
			@mp3Url = 'http://0.0.0.0:3000/audio/test.mp3';
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
			}
			return allItems.to_json();
		end

	end
end

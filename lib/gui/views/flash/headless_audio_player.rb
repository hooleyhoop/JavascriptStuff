module GUI::Views::Flash

	# http://0.0.0.0:3000/widgets/headlessPlayer
	class HeadlessAudioPlayer < GUI::Core::HooView

		attr_accessor :mp3Url;

		def initialize( args={} )
			super(args);
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
				:mp3Url		=> @mp3Url,
			}
			return allItems.to_json();
		end

	end
end

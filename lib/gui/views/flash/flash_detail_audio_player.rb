module GUI::Views::Flash

	# http://0.0.0.0:3000/widgets/flashDetailPlayer?swf=http://0.0.0.0:3000/flash/DefaultPlayerV10/lib/Debug/default_player_10.swf&width=500&height=100
	class FlashDetailAudioPlayer < GUI::Core::HooView

		attr_accessor :swf;
		attr_accessor :width;
		attr_accessor :height;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:swf=>'http://0.0.0.0:3000/flash/SharedComponents/ProgressBarComponent/lib/Debug/ProgressbarComponent.swf', :width=>105, :height=>45} );
		end

		# Mock Data
		def setupDebugFixture
			super();
			@mp3Url = 'http://0.0.0.0:3000/flash/SharedComponents/ProgressBarComponent/lib/Debug/ProgressbarComponent.swf';
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:swf		=> @mp3Url,
				:width		=> @width,
				:height		=> @height
			}
			return allItems.to_json();
		end

	end
end

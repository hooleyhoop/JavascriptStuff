module Gui::Views::Players::Old

	# http://0.0.0.0:3000/widgets/adam_detailPlayer
	class AdamDetailPlayer < Gui::Core::HooView

		attr_accessor :playerLeft, :playerRight, :playerMid, :playButton, :carat;
		attr_accessor :playerLeft2, :playerRight2, :playerMid2
		attr_accessor :durationString

		def initialize( args={} )
			super(args);

			@playerLeft		= '../images/player/player-left-cap.png';
			@playerMid		= '../images/player/player-mid.png';
			@playerRight	= '../images/player/player-right-cap.png';

			@playerLeft2	= '../images/player/player-left-cap2.png';
			@playerMid2		= '../images/player/player-mid2.png';
			@playerRight2	= '../images/player/player-right-cap2.png';

			@playButton		= '../images/player/play-button.png';
			@carat			= '../images/player/carat.png';

			@durationString = '03:23'
		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

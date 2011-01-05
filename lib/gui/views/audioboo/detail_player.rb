module GUI::Views::Audioboo

	class DetailPlayer < GUI::Core::HooView

        attr_accessor :playerLeft, :playerRight, :playerMid, :playButton, :carat;
        attr_accessor :playerLeft2, :playerRight2, :playerMid2

		def initialize( args={} )
			super();

    		@playerLeft = '../images/player/player-left-cap.png';
    		@playerMid = '../images/player/player-mid.png';
    		@playerRight = '../images/player/player-right-cap.png';

    		@playerLeft2 = '../images/player/player-left-cap2.png';
    		@playerMid2 = '../images/player/player-mid2.png';
    		@playerRight2 = '../images/player/player-right-cap2.png';

    		@playButton = '../images/player/play-button.png';
    		@carat = '../images/player/carat.png';
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

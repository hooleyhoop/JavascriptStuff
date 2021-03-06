module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/MultipleBeeperTestHtml5

	class MultipleBeeperTestHtml5 < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = widgetClass('BeeperTestHtml5').new( {:mp3Url=>'http://audioboo.fm/boos/393446-converting-arr-to-mp3-for-an-audioboo.mp3'} );
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = widgetClass('BeeperTestHtml5').new( {:mp3Url=>'http://audioboo.fm/boos/197170.mp3'} );
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = widgetClass('BeeperTestHtml5').new( {:mp3Url=>'http://audioboo.fm/boos/392103-bookreview-tore-renberg-und-zum-fruehstueck-heller-sirup-in-german.mp3'} );
	        addSubView( flashSharedInstance3 );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

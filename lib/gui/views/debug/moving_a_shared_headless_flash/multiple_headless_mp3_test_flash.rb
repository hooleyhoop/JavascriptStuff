module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://shooley.audioboo.fm:3000/widgets/multiple_headless_mp3_test_flash

	class MultipleHeadlessMp3TestFlash < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = wc('headless_mp3_test_flash').new( {:mp3Url=>'http://audioboo.fm/boos/313426-the-rose.mp3'} );
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = Gui::HooWidgetList.widgetClass('headless_mp3_test_flash').new( {:mp3Url=>'http://audioboo.fm/boos/197170.mp3'} );
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = Gui::HooWidgetList.widgetClass('headless_mp3_test_flash').new( {:mp3Url=>'http://audioboo.fm/boos/392103-bookreview-tore-renberg-und-zum-fruehstueck-heller-sirup-in-german.mp3'} );
	        addSubView( flashSharedInstance3 );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

module GUI::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/multiplebeepertesthtml5

	class MultipleBeeperTestHTML5 < GUI::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = wc('beepertesthtml5').new( {:mp3Url=>'http://audioboo.fm/boos/313426-the-rose.mp3'} );
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = GUI::HooWidgetList.widgetClass('beepertesthtml5').new( {:mp3Url=>'http://audioboo.fm/boos/197170.mp3'} );
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = GUI::HooWidgetList.widgetClass('beepertesthtml5').new( {:mp3Url=>'http://audioboo.fm/boos/392103-bookreview-tore-renberg-und-zum-fruehstueck-heller-sirup-in-german.mp3'} );
	        addSubView( flashSharedInstance3 );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

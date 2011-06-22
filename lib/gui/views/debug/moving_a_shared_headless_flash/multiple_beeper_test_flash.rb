module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://shooley.audioboo.fm:3000/widgets/multiplebeepertestflash

	class MultipleBeeperTestFlash < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = Gui::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = Gui::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = Gui::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

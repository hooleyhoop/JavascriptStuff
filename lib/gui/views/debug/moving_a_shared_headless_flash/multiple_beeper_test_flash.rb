module GUI::Views::Debug::MovingASharedHeadlessFlash

    # http://0.0.0.0:3000/widgets/multiplebeepertestflash

	class MultipleBeeperTestFlash < GUI::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = GUI::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = GUI::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = GUI::HooWidgetList.widgetClass('beepertestflash').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

module GUI::Views::Debug

    # http://0.0.0.0:3000/widgets/flashsharedelement

	# The purpose of this is ONLY to be used by FlashSharedElementTest
	class FlashSharedElement < GUI::Core::HooView

		def initialize( args={} )
			super(args);

			flashSharedInstance1 = GUI::HooWidgetList.widgetClass('widgetResizer').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = GUI::HooWidgetList.widgetClass('widgetResizer').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = GUI::HooWidgetList.widgetClass('widgetResizer').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

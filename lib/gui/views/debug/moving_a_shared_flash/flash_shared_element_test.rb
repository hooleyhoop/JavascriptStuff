module Gui::Views::Debug::MovingASharedFlash

    # http://0.0.0.0:3000/widgets/FlashSharedElementTest

	class FlashSharedElementTest < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = widgetClass('FlashSharedElement').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = widgetClass('FlashSharedElement').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = widgetClass('FlashSharedElement').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

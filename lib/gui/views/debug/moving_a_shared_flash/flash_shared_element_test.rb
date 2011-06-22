module Gui::Views::Debug::MovingASharedFlash

    # http://0.0.0.0:3000/widgets/flashsharedelementtest

	class FlashSharedElementTest < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = Gui::HooWidgetList.widgetClass('flashsharedelement').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = Gui::HooWidgetList.widgetClass('flashsharedelement').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = Gui::HooWidgetList.widgetClass('flashsharedelement').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

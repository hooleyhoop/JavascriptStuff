module Gui::Views::Debug::MovingASharedHeadlessFlash

    # http://shooley.audioboo.fm:3000/widgets/MultipleBeeperTestFlash

	class MultipleBeeperTestFlash < Gui::Core::HooView

		# Put a wodge of shared flash elements of the page to see what happens
		def initialize( args={} )
			super(args);

			flashSharedInstance1 = widgetClass('BeeperTestFlash').new();
	        addSubView( flashSharedInstance1 );

        	flashSharedInstance2 = widgetClass('BeeperTestFlash').new();
	        addSubView( flashSharedInstance2 );

        	flashSharedInstance3 = widgetClass('BeeperTestFlash').new();
	        addSubView( flashSharedInstance3 );

		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

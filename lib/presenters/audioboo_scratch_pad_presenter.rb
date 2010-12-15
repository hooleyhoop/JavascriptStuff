include Gui

module Presenters
	class AudiobooScratchPadPresenter < HooPresenter

        def initialize( controller )

			super( controller );

			spacerView 			= widgetClass('spacerView');
			loremIpsumView 		= widgetClass('loremIpsum');
			slidingDoorsPanel   = widgetClass('slidingDoorsPanel1')

            @singleItem = true;

            if( @singleItem )

                outerPanel = slidingDoorsPanel.new();
                innerPanel = slidingDoorsPanel.new();
                innerPanel.imgPath = '../images/innerpanel/inner_panel';

                loremIpsumView = loremIpsumView.new();

                @window.contentView.addSubView( outerPanel );
                outerPanel.addSubView( loremIpsumView );

    	#		outerPanel.addSubView( innerPanel );
    	#		innerPanel.addSubView( loremIpsumView );

            else

				sideBarSpacer = spacerView.new( 15, 15, 15, 15 );
                @window.contentView.addSubView( sideBarSpacer );

                slidingDoorsPanel1 = slidingDoorsPanel.new();
                sideBarSpacer.addSubView( slidingDoorsPanel1 );

                loremIpsumView = loremIpsumView.new();
                slidingDoorsPanel1.addSubView( loremIpsumView );
            end

        end

	end
end

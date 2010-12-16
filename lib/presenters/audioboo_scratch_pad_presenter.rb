include Gui

module Presenters
	class AudiobooScratchPadPresenter < HooPresenter

        def initialize( controller )

			super( controller );

			spacerView 			= widgetClass('spacerView');
			loremIpsumView 		= widgetClass('loremIpsum');
			slidingDoorsPanel   = widgetClass('slidingDoorsPanel1')
			speechBubblePane    = widgetClass('speechBubblePane')
			verticalSplitView   = widgetClass('verticalSplitView')
			horizontalSplitView = widgetClass('horizontalSplitView')

            @singleItem = false;

            if( @singleItem )

                @window.showGrid;

                #divider = verticalSplitView.new();
                #divider.setFixedColumn( 'right', 50 );
                #divider.addSubView( bubble );

                outerPanel = slidingDoorsPanel.new();
                outerPanel.style = 'main'
                @window.contentView.addSubView( outerPanel );

                bubble = speechBubblePane.new();
                bubble.speechPosition = 'right'
                bubble.constructSubViews();
                outerPanel.addSubView( bubble );

                loremIpsumView2 = loremIpsumView.new();
                bubble.addSubView( loremIpsumView2 );


#                innerPanel1 = speechBubblePane.new();
#                innerPanel1.imgPath = '../images/innerpanel/inner_panel';

#    			outerPanel.addSubView( innerPanel1 );

#                loremIpsumView1 = loremIpsumView.new();
#    			innerPanel1.addSubView( loremIpsumView1 );

       #         innerPanel2 = slidingDoorsPanel.new();
       #         innerPanel2.imgPath = '../images/innerpanel/inner_panel';

      #          loremIpsumView2 = loremIpsumView.new();
    #			innerPanel2.addSubView( loremIpsumView2 );

    #			outerPanel.addSubView( innerPanel2 );

            else

                # Some breathing space
				sideBarSpacer = spacerView.new( 15, 15, 15, 15 );
                @window.contentView.addSubView( sideBarSpacer );

                # Outer Panel
                outerPanel = slidingDoorsPanel.new();
                outerPanel.style = 'main'
                sideBarSpacer.addSubView( outerPanel );

                # User Info Panel
                userBubble = speechBubblePane.new();
                userBubble.speechPosition = 'bottom'
                userBubble.constructSubViews();
                outerPanel.addSubView( userBubble );

                loremIpsumView1 = loremIpsumView.new();
                userBubble.addSubView( loremIpsumView1 );

                #Main Boo Panel
                mainBooPanel = slidingDoorsPanel.new();
                mainBooPanel.style = 'inner'
                outerPanel.addSubView( mainBooPanel );

                loremIpsumView2 = loremIpsumView.new();
                mainBooPanel.addSubView( loremIpsumView2 );

            end

        end

	end
end

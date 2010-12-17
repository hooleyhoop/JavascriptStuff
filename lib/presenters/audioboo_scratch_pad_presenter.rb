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
            singlebuttonForm    = widgetClass('singlebuttonForm')
            followButtonSection = widgetClass('followButtonSection')
            userDetailsBanner   = widgetClass('userDetailsBanner')

            @singleItem = false;

            if( @singleItem )

                @window.showGrid;

                #divider = verticalSplitView.new();
                #divider.setFixedColumn( 'right', 50 );
                #divider.addSubView( bubble );

                outerPanel = slidingDoorsPanel.new();
                outerPanel.style = 'main'
             #   @window.contentView.addSubView( outerPanel );

                bubble = speechBubblePane.new();
                bubble.speechPosition = 'right'
                bubble.constructSubViews();
                outerPanel.addSubView( bubble );

           #     loremIpsumView2 = loremIpsumView.new();
           #     bubble.addSubView( loremIpsumView2 );

                # float this left
           #     pressyThing1 = singlebuttonForm.new();
           #     pressyThing1.img = '../images/buttons/follow.png';
		#	    pressyThing1.width = 90;
    	#		pressyThing1.height = 90;

         #       bubble.addSubView( pressyThing1 );

                # float this one right, make sure it stays aligned to the top
                userDetailsBanner = userDetailsBanner.new();
                userDetailsBanner.img = '../images/buttons/follow-button.png';
			    userDetailsBanner.width = 90;
    			userDetailsBanner.height = 90;

                @window.contentView.addSubView( userDetailsBanner );

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

                # float this one right, make sure it stays aligned to the top
                followSection = followButtonSection.new();
                followSection.img = '../images/buttons/follow-button.png';
			    followSection.width = 90;
    			followSection.height = 90;
                userBubble.addSubView( followSection );

                # The user name and pic, etc.
                userDetailsBanner = userDetailsBanner.new();
                userBubble.addSubView( userDetailsBanner );

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

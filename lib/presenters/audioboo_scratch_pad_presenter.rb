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
            fixedSizeImage      = widgetClass('fixedSizeImage')
            hoo100PercentImg    = widgetClass('hoo100PercentImg')
            booMainDetails      = widgetClass('booMainDetails')
            detailPlayer        = widgetClass('detailPlayer')
            spacedVerticalList  = widgetClass('spacedVerticalList')
            twoElasticColsFixedGutter  = widgetClass('twoElasticColsFixedGutter')

            @singleItem = false;

            if( @singleItem )

                @window.showGrid;

                list = twoElasticColsFixedGutter.new();
                @window.contentView.addSubView( list );

                promotionPlaceHolder1 = loremIpsumView.new();
    			list.addSubView( promotionPlaceHolder1 );

                promotionPlaceHolder2 = loremIpsumView.new();
    			list.addSubView( promotionPlaceHolder2 );

            else
                #@window.showGrid;

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
			    followSection.width = 105;
    			followSection.height = 45;
    			followSection.label = 'Follow';
                userBubble.addSubView( followSection );

                # The user name and pic, etc.
                userDetailsBanner = userDetailsBanner.new();
                userDetailsBanner.img = '../images/user/my_pic.png';
                userDetailsBanner.width = 75;
                userDetailsBanner.height = 75;
                userDetailsBanner.userName = 'stevehooley';
                userBubble.addSubView( userDetailsBanner );

                #Main Boo Panel
                mainBooPanel = slidingDoorsPanel.new();
                mainBooPanel.style = 'inner'
                outerPanel.addSubView( mainBooPanel );

                # split 50% left right
                divider = verticalSplitView.new();
                #divider.setPercentage( 'left', 50 );
                divider.setFixedColumn( 'right', 23*15 )
                mainBooPanel.addSubView( divider );

                # LEFT SIDE
				mainBooDetailsSpacer = spacerView.new( 0, 15, 0, 0 );
                divider.addSubView( mainBooDetailsSpacer );

                listView1 = spacedVerticalList.new();
                mainBooDetailsSpacer.addSubView( listView1 );

                mainBooDetails = booMainDetails.new();
                listView1.addSubView( mainBooDetails );

                thePlayer = detailPlayer.new();
                listView1.addSubView( thePlayer );

                # RIGHT SIDE
                divider2 = verticalSplitView.new();
                divider2.setFixedColumn( 'right', 15*7 );

                divider.addSubView( divider2 );

				imageSpacer = spacerView.new( 0, 15, 0, 0 );
                divider2.addSubView( imageSpacer );

                booImage = hoo100PercentImg.new();
                booImage.img = '../images/boo/sampleImage2.jpg';
                imageSpacer.addSubView( booImage );

                mapImg = fixedSizeImage.new();
                mapImg.img = '../images/map/map-icon.png';
                mapImg.width = 15*7;
    			mapImg.height = 15*7;
                mapImg.label = 'map'
                mapImg.labelLink = 'www.apple.com'
                divider2.addSubView( mapImg );

                # Bottom section
                bottomSpacer = spacerView.new( 15, 15, 15, 15 );
                outerPanel.addSubView( bottomSpacer );

                promotionPlaceHolder = loremIpsumView.new();
    			bottomSpacer.addSubView( promotionPlaceHolder );

                promotionPlaceHolder2 = loremIpsumView.new();
    			bottomSpacer.addSubView( promotionPlaceHolder2 );
            end

        end

	end
end

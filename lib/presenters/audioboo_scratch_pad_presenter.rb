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
            tableHeader         = widgetClass('tableHeader')
            croppedImg         = widgetClass('croppedImg')
            croppedImgWithHeader= widgetClass('croppedImgWithHeader')

            @singleItem = false;

            if( @singleItem )

                @window.showGrid;

                split = twoElasticColsFixedGutter.new();
                @window.contentView.addSubView( split );

                spacedVerticalList1 = spacedVerticalList.new();
    			split.addSubView( spacedVerticalList1 );

                header1 = tableHeader.new();
                header1.label = 'May i recomend?'
                header1.color = 'blue';
    			spacedVerticalList1.addSubView( header1 );

                header2 = tableHeader.new();
                header2.label = 'Image from the gods'
                header2.color = 'lime';
    			spacedVerticalList1.addSubView( header2 );

                header3 = tableHeader.new();
                header3.label = 'great map view'
                header3.color = 'orange';
    			spacedVerticalList1.addSubView( header3 );

                header4 = tableHeader.new();
                header4.label = 'smelly wagstaff'
                header4.color = 'pink';
    			spacedVerticalList1.addSubView( header4 );

                # right hand side
                img = croppedImgWithHeader.new();
                img.label = 'skanky fank fank'
                img.color = 'lime';
                img.path = '../images/boo/sampleImage5.jpg';
    			split.addSubView( img );

                #promotionPlaceHolder2 = loremIpsumView.new();

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

                # RIGHT SIDE - here's where we can really feel the power & speed of presenters
                # TODO: Different layouts depending which elements are present
                rightSideList = spacedVerticalList.new();
                divider.addSubView( rightSideList );

                # RIGHT SIDE - Images
                divider2 = twoElasticColsFixedGutter.new();
                rightSideList.addSubView( divider2 );

                booImage = croppedImgWithHeader.new();
                booImage.label = 'Image'
                booImage.color = 'lime';
                booImage.path = '/images/boo/sampleImage5.jpg';
                #mapImg.labelLink = 'www.apple.com'
    			divider2.addSubView( booImage );

                mapImg = croppedImgWithHeader.new();
                mapImg.label = 'Location'
                mapImg.color = 'orange';
                mapImg.path = '../images/map/map_image.jpg';
                #mapImg.labelLink = 'www.apple.com'
    			divider2.addSubView( mapImg );

                # RIGHT SIDE - Tags
                divider3 = twoElasticColsFixedGutter.new();
                rightSideList.addSubView( divider3 );

                tagsTable = TableList.new();
                infoTable = TableList.new();
    			divider3.addSubView( tagsTable );
    			divider3.addSubView( infoTable );

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

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
            tableList           = widgetClass('tableList')

            @singleItem = false;

            if( @singleItem )

                @window.showGrid;

                spacedVerticalList1 = spacedVerticalList.new();
    			@window.contentView.addSubView( spacedVerticalList1 );

                tagsTable = tableList.new();
                tagsTable.label = 'Info'
                tagsTable.color = 'pink'
                spacedVerticalList1.addSubView( tagsTable );

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

                tagsTable1 = tableList.new( :style=>'continuousText' );
                tagsTable1.label = 'Tags'
                tagsTable1.color = 'blue'
                tagsTable1.content = [

                    { 'name'=>'motiongraphics',     'url'=> '#' },
                    { 'name'=>'aftereffects',      	'url'=> '#' },
                    { 'name'=>'cinema 4D',      'url'=> '#' },
                    { 'name'=>'C4D',      'url'=> '#' },
                    { 'name'=>'mograph',      'url'=> '#' },
                    { 'name'=>'cube',      'url'=> '#' },
                    { 'name'=>'sphere',      'url'=> '#' },
                    { 'name'=>'hsgn',      'url'=> '#' },
                    { 'name'=>'hosogane',      'url'=> '#' },
                    { 'name'=>'bonsajo',      'url'=> '#' },
                    { 'name'=>'cubesato',      'url'=> '#' },
                    { 'name'=>'sweez',      'url'=> '#' },
                ];
                divider3.addSubView( tagsTable1 );

                # RightSide - Info
                infoTable = tableList.new( :style=>'textList' );
                infoTable.label = 'Info'
                infoTable.color = 'pink'
                infoTable.content = [
                    { 'name'=>'number of plays: 0',     'url'=> '#' },
                    { 'name'=>'report this boo',      	'url'=> '#' },
                    { 'name'=>'download this boo',      'url'=> '#' },
                ];

                divider3.addSubView( infoTable );

                # RightSide - Related Boos
                relatedBoosTable = tableList.new( :style=>'cell' );
                relatedBoosTable.label = 'Related Boos'
                relatedBoosTable.color = 'orange'
                relatedBoosTable.content = [
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/my_pic.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/my_pic.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/my_pic.png'  },
                ];

                rightSideList.addSubView( relatedBoosTable );


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

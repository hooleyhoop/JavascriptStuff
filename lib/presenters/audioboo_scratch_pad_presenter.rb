module Presenters
	class AudiobooScratchPadPresenter < HooPresenter

		include Gui

        def initialize( controller )

			super( controller );

			spacerView				= widgetClass('spacerView');
			loremIpsumView			= widgetClass('loremIpsum');
			slidingDoorsPanel		= widgetClass('slidingDoorsPanel1')
			speechBubblePane		= widgetClass('speechBubblePane')
			verticalSplitView		= widgetClass('verticalSplitView')
			horizontalSplitView		= widgetClass('horizontalSplitView')
			largeSinglebuttonForm	= widgetClass('largeSinglebuttonForm')
			followButtonSection		= widgetClass('followButtonSection')
			userDetailsBanner		= widgetClass('userDetailsBanner')
			fixedSizeImage			= widgetClass('fixedSizeImage')
			hoo100PercentImg		= widgetClass('hoo100PercentImg')
			booMainDetails			= widgetClass('booMainDetails')
			detailPlayer			= widgetClass('detailPlayer')
			spacedVerticalList		= widgetClass('spacedVerticalList')
			twoElasticColsFixedGutter  = widgetClass('twoElasticColsFixedGutter')
			tableHeader				= widgetClass('tableHeader')
			croppedImg				= widgetClass('croppedImg')
			croppedImgWithHeader	= widgetClass('croppedImgWithHeader')
			tableList				= widgetClass('tableList')
			colorFill				= widgetClass('colorFill')
			addComment				= widgetClass('addComment')
			allCommentsTable		= widgetClass('all_user_comments')
			footer					= widgetClass('footer')
			editbarView				= widgetClass('editBar')

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
                userBubble.addSubView( followSection );

                # The user name and pic, etc.
                userDetailsBanner = userDetailsBanner.new();
                userDetailsBanner.img = '../images/user/sample_user1.png';
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

                # LeftSide - description
                booDescription = loremIpsumView.new();
                listView1.addSubView( booDescription );

                # LeftSide - comments
                addAComment = addComment.new();
			    addAComment.img = '../images/user/sample_user2.png';
                addAComment.postButtonImg = '../images/buttons/post-button.png';
                addAComment.width = 75;
                addAComment.height = 75;
                listView1.addSubView( addAComment );

                allComments = allCommentsTable.new();
                listView1.addSubView( allComments );

                # RIGHT SIDE - here's where we can really feel the power & speed of presenters
                # TODO: Different layouts depending which elements are present
                rightSideList = spacedVerticalList.new();
                divider.addSubView( rightSideList );

				#right side - edit bar
				editbar = editbarView.new();
				rightSideList.addSubView( editbar );

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
                    { 'name'=>'number of plays: 0',     'url'=> '' },
                    { 'name'=>'report this boo',      	'url'=> '#' },
                    { 'name'=>'download this boo',      'url'=> '#' },
                ];

                divider3.addSubView( infoTable );

                # RightSide - Related Boos
                relatedBoosTable = tableList.new( :style=>'cell' );
                relatedBoosTable.label = 'Related Boos'
                relatedBoosTable.color = 'orange'
                relatedBoosTable.content = [
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user3.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user4.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user5.png'  },
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user6.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user7.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user8.png'  },
                ];

                rightSideList.addSubView( relatedBoosTable );

                # Rightside - Popular Boos
                popularBoosTable = tableList.new( :style=>'cell' );
                popularBoosTable.label = 'Popular Boos'
                popularBoosTable.color = 'blue'
                popularBoosTable.content = [
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user9.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user10.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user2.png'  },
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user4.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user3.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user1.png'  },
                ];

                rightSideList.addSubView( popularBoosTable );


                # Bottom section
                bottomSpacer = spacerView.new( 15, 0, 15, 0 );
                outerPanel.addSubView( bottomSpacer );

                footerView = footer.new();
                footerView.allItems = [

                [   { 'name' =>'About Us',     'url'=> '#' },
                    { 'name' =>'Audioboo Pro',     'url'=> '#' },
                    { 'name' =>'Developers',     'url'=> '#' },
                    { 'name' =>'Widgets',     'url'=> '#' }, ],

                [   { 'name' =>'Support/Discussion',     'url'=> '#' },
                    { 'name' =>'Community Guidelines',     'url'=> '#' },
                    { 'name' =>'Terms & Conditions',     'url'=> '#' },
                    { 'name' =>'Privacy Policy',     'url'=> '#' }, ],

                [   { 'name' =>'Quick Tour',     'url'=> '#' },
                    { 'name' =>'Watch a video intro',     'url'=> '#' },
                    { 'name' =>'Follow us on Twitter',     'url'=> '#' },
                    { 'name' =>'Join our Facebook Group',     'url'=> '#' }, ],

                [   { 'name' =>'Latest from the blog',     'url'=> '#' },
                    { 'name' =>'iPhone App 2.0',     'url'=> '#' },
                    { 'name' =>'RIP 4IP',     'url'=> '#' },
                    { 'name' =>'audioMo',     'url'=> '#' }, ],
                ];

    			bottomSpacer.addSubView( footerView );
                #promotionPlaceHolder2 = loremIpsumView.new();
    			#bottomSpacer.addSubView( promotionPlaceHolder2 );

			end

		end

	end
end

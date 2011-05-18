module Presenters
	# http://0.0.0.0:3000/pages/test_audioboo_stuff
	class AudiobooScratchPadPresenter < HooPresenter

		include Gui

        def initialize( controller )

			super( controller );

			spacerView					= widgetClass('spacerView');
			loremIpsumView				= widgetClass('loremIpsum');
			slidingDoorsPanel			= widgetClass('slidingDoorsPanel1')
			verticalSplitView			= widgetClass('verticalSplitView')
			horizontalSplitView			= widgetClass('horizontalSplitView')
			followButtonSection			= widgetClass('followButtonSection')
			userDetailsBanner			= widgetClass('userDetailsBanner')
			fixedSizeImage				= widgetClass('fixedSizeImage')
			hoo100PercentImg			= widgetClass('hoo100PercentImg')
			booMainDetails				= widgetClass('booMainDetails')
			detailPlayer				= widgetClass('detailPlayer')
			spacedVerticalList			= widgetClass('spacedVerticalList')
			twoElasticColsFixedGutter	= widgetClass('twoElasticColsFixedGutter')
			tableHeader					= widgetClass('tableHeader')
			croppedImg					= widgetClass('croppedImg')
			croppedImgWithHeader		= widgetClass('croppedImgWithHeader')
			tableList					= widgetClass('tableList')
			colorFill					= widgetClass('colorFill')
			addComment					= widgetClass('addComment')
			allCommentsTable			= widgetClass('all_user_comments')
			footer						= widgetClass('footer')
			editbarView					= widgetClass('editBar')
			speechBubbleBottomClass		= widgetClass('speechBubbleBottomCanvas')
			speechBubblePaneClass		= widgetClass('speechBubblePane')

			#@window.showGrid;

			@singleItem = false;

            if( @singleItem )

                spacedVerticalList1 = spacedVerticalList.new();
    			@window.contentView.addSubView( spacedVerticalList1 );

                tagsTable = tableList.new();
                tagsTable.label = 'Info'
                tagsTable.color = 'pink'
 				tagsTable.content = [
				# remember, the hash rocked is dead!
     				{ name: 'motiongraphics',	url: '#' },
					{ name: 'aftereffects',     url: '#' },
                 ];
                spacedVerticalList1.addSubView( tagsTable );

                #promotionPlaceHolder2 = loremIpsumView.new();

            else
                # Some breathing space
				sideBarSpacer = spacerView.new( 15, 15, 15, 15 );
				@window.contentView.addSubView( sideBarSpacer );

				# Outer Panel
				outerPanel = slidingDoorsPanel.new();
				outerPanel.style = 'main'
				sideBarSpacer.addSubView( outerPanel );

				# User Info Panel
				userBubble = speechBubbleBottomClass.new();
				#userBubble.speechPosition = 'bottom'
				userBubble.constructSubViews();
				outerPanel.addSubView( userBubble );

				# float this one right, make sure it stays aligned to the top
				followSection = followButtonSection.new();
				userBubble.addSubView( followSection );

				# The user name and pic, etc.
				userDetailsBanner = userDetailsBanner.new();
				userDetailsBanner.img = '../images/user/sample_user1.png';
				userDetailsBanner.imgSize = [75,75];
				userDetailsBanner.userName = 'stevehooley';
				userDetailsBanner.userHomePageURL = 'http://apple.com'

				# This is a bit wrong as the hash isnt ordered, so these could come out in any order
				userDetailsBanner.stats = {
						boos: { total:190, url: 'http://apple.com'},
						favourites: { total:3, url: 'http://virgin.com'},
						followers: { total:347, url: 'http://facebook.com'}
						};
				userBubble.addSubView( userDetailsBanner );

                #Main Boo Panel
                mainBooPanel = slidingDoorsPanel.new();
                mainBooPanel.style = 'inner'
                outerPanel.addSubView( mainBooPanel );

                # split 50% left right
                divider = verticalSplitView.new();
                divider.setPercentage( 'left', 50 );
                divider.setFixedColumn( 'right', 23*15 )
                mainBooPanel.addSubView( divider );

                # LEFT SIDE
				mainBooDetailsSpacer = spacerView.new( 0, 15, 0, 0 );
                divider.addSubView( mainBooDetailsSpacer );

                listView1 = spacedVerticalList.new();
                mainBooDetailsSpacer.addSubView( listView1 );

                mainBooDetails = booMainDetails.new();
                listView1.addSubView( mainBooDetails );

                #derp thePlayer = detailPlayer.new();
                #derp listView1.addSubView( thePlayer );

                # LeftSide - description
                #comeback booDescription = loremIpsumView.new();
                #comeback listView1.addSubView( booDescription );

                # LeftSide - comments
                #comeback addAComment = addComment.new();
			    #comeback addAComment.img = '../images/user/sample_user2.png';
                #comeback addAComment.postButtonImg = '../images/buttons/post-button.png';
                #comeback addAComment.width = 75;
                #comeback addAComment.height = 75;
                #comeback listView1.addSubView( addAComment );

                #comeback allComments = allCommentsTable.new();
                #comeback listView1.addSubView( allComments );

                # RIGHT SIDE - here's where we can really feel the power & speed of presenters
                # TODO: Different layouts depending which elements are present
                rightSideList = spacedVerticalList.new();
                divider.addSubView( rightSideList );

				#right side - edit bar
				#editbar = editbarView.new();
				#rightSideList.addSubView( editbar );

                # RIGHT SIDE - Images
                #derp divider2 = twoElasticColsFixedGutter.new();
                #derp rightSideList.addSubView( divider2 );

                #derp booImage = croppedImgWithHeader.new();
                #derp booImage.label = 'Image'
                #derp booImage.color = 'lime';
                #derp booImage.path = '/images/boo/sampleImage5.jpg';
                #mapImg.labelLink = 'www.apple.com'
    			#derp divider2.addSubView( booImage );

                mapImg = croppedImgWithHeader.new();
                mapImg.label = 'Location'
                mapImg.color = 'orange';
                mapImg.path = '../images/map/map_image.jpg';
                #mapImg.labelLink = 'www.apple.com'
    			rightSideList.addSubView( mapImg );

                # RIGHT SIDE - Tags
                #comeback divider3 = twoElasticColsFixedGutter.new();
                #comeback rightSideList.addSubView( divider3 );

                #comeback tagsTable1 = tableList.new( :style=>'continuousText' );
                #comeback tagsTable1.label = 'Tags'
                #comeback tagsTable1.color = 'blue'
                #comeback tagsTable1.content = [
				# remember, the hash rocked is dead!
                #comeback     { 'name'=>'motiongraphics',     'url'=> '#' },
                #comeback     { 'name'=>'aftereffects',      	'url'=> '#' },
                #comeback     { 'name'=>'cinema 4D',      'url'=> '#' },
                #comeback     { 'name'=>'C4D',      'url'=> '#' },
                #comeback     { 'name'=>'mograph',      'url'=> '#' },
                #comeback     { 'name'=>'cube',      'url'=> '#' },
                #comeback     { 'name'=>'sphere',      'url'=> '#' },
                #comeback     { 'name'=>'hsgn',      'url'=> '#' },
                #comeback     { 'name'=>'hosogane',      'url'=> '#' },
                #comeback     { 'name'=>'bonsajo',      'url'=> '#' },
                 #comeback    { 'name'=>'cubesato',      'url'=> '#' },
                 #comeback    { 'name'=>'sweez',      'url'=> '#' },
                #comeback ];
                #comeback divider3.addSubView( tagsTable1 );

                # RightSide - Info
               #comeback infoTable = tableList.new( :style=>'textList' );
               #comeback  infoTable.label = 'Info'
               #comeback  infoTable.color = 'pink'
               #comeback  infoTable.content = [
               #comeback      { 'name'=>'number of plays: 0',     'url'=> '' },
               #comeback      { 'name'=>'report this boo',      	'url'=> '#' },
               #comeback      { 'name'=>'download this boo',      'url'=> '#' },
              #comeback   ];

              #comeback  divider3.addSubView( infoTable );

                # RightSide - Related Boos
             #comeback    relatedBoosTable = tableList.new( :style=>'cell' );
             #comeback    relatedBoosTable.label = 'Related Boos'
             #comeback    relatedBoosTable.color = 'orange'
             #comeback    relatedBoosTable.content = [
             #comeback        { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user3.png' },
            #comeback         { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user4.png'  },
            #comeback         { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user5.png'  },
            #comeback         { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user6.png' },
            #comeback         { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user7.png'  },
           #comeback          { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user8.png'  },
            #comeback     ];

            #comeback    rightSideList.addSubView( relatedBoosTable );

                # Rightside - Popular Boos
             #comeback    popularBoosTable = tableList.new( :style=>'cell' );
             #comeback    popularBoosTable.label = 'Popular Boos'
             #comeback    popularBoosTable.color = 'blue'
             #comeback    popularBoosTable.content = [
             #comeback        { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user9.png' },
            #comeback         { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user10.png'  },
            #comeback         { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user2.png'  },
            #comeback         { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/sample_user4.png' },
           #comeback          { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/sample_user3.png'  },
           #comeback          { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/sample_user1.png'  },
           #comeback      ];

           #comeback      rightSideList.addSubView( popularBoosTable );


                # Bottom section
          #comeback      bottomSpacer = spacerView.new( 15, 0, 15, 0 );
          #comeback       outerPanel.addSubView( bottomSpacer );

          #comeback       footerView = footer.new();
           #comeback      footerView.allItems = [

          #comeback       [   { 'name' =>'About Us',     'url'=> '#' },
          #comeback           { 'name' =>'Audioboo Pro',     'url'=> '#' },
          #comeback           { 'name' =>'Developers',     'url'=> '#' },
          #comeback           { 'name' =>'Widgets',     'url'=> '#' }, ],

          #comeback       [   { 'name' =>'Support/Discussion',     'url'=> '#' },
          #comeback           { 'name' =>'Community Guidelines',     'url'=> '#' },
          #comeback           { 'name' =>'Terms & Conditions',     'url'=> '#' },
          #comeback           { 'name' =>'Privacy Policy',     'url'=> '#' }, ],

          #comeback      [   { 'name' =>'Quick Tour',     'url'=> '#' },
          #comeback           { 'name' =>'Watch a video intro',     'url'=> '#' },
          #comeback           { 'name' =>'Follow us on Twitter',     'url'=> '#' },
         #comeback           { 'name' =>'Join our Facebook Group',     'url'=> '#' }, ],
#comeback
         #comeback        [   { 'name' =>'Latest from the blog',     'url'=> '#' },
         #comeback            { 'name' =>'iPhone App 2.0',     'url'=> '#' },
         #comeback            { 'name' =>'RIP 4IP',     'url'=> '#' },
        #comeback             { 'name' =>'audioMo',     'url'=> '#' }, ],
        #comeback         ];

    	#comeback 		bottomSpacer.addSubView( footerView );
                #promotionPlaceHolder2 = loremIpsumView.new();
    			#bottomSpacer.addSubView( promotionPlaceHolder2 );

			end

		end

	end
end

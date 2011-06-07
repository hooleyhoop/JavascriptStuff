module Presenters
	# http://javascriptstuff.dev/pages/flash_replace_test
	class FlashReplaceTestPresenter < HooPresenter

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

			@singleItem = true;

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

				#table view
				#mock flash cell

				#addRw
				#addRw
				#addRw

            else

			end

		end

	end
end

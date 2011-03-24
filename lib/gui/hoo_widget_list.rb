module GUI
	class HooWidgetList

		require "gui/views/drawing.rb"

		@@layouts = {
			'fixedWidthSingleCol'	=>	GUI::Layouts::HooFixedSingleColView.name,
			'elasticColRight'		=>	GUI::Layouts::HooElasticColRightView.name,
			'elasticColLeft'		=>	GUI::Layouts::HooElasticColLeftView.name,
			'elasticColBoth'		=>	GUI::Layouts::HooElasticColBothView.name,

		}

		def self.layoutClass( name )

			layoutName = @@layouts[name]
			if(layoutName==nil)
				raise "Layout "+name+" not found!"
			end
			layoutName.constantize
		end


		@@widgets = {

			# for positioning
			'verticalSplitView'				=>	GUI::Views::Positioning::HooVerticalSplitView.name,
			'horizontalSplitView'			=>	GUI::Views::Positioning::HooHorizontalSplitView.name,
			'spacerView'					=>	GUI::Views::Positioning::HooSpacerView.name,
			'relativeOffsetView'			=>	GUI::Views::Positioning::HooRelativeOffsetView.name,
			'twoElasticColsFixedGutter'		=>	GUI::Views::Positioning::HooTwoElasticColsFixedGutter.name,

			# These have a percentage spacing, not what i want!
			'2col_percent_padded'			=>	GUI::Views::Positioning::Hoo2ColPercentPaddedView.name,
			'3col_percent_padded'			=>	GUI::Views::Positioning::Hoo3ColPercentPaddedView.name,
			'4col_percent_padded'			=>	GUI::Views::Positioning::Hoo4ColPercentPaddedView.name,
			'5col_percent_padded'			=>	GUI::Views::Positioning::Hoo5ColPercentPaddedView.name,

			# What i want is fixed space
			'2col'							=>	GUI::Views::Positioning::Hoo2ColView.name,
			'3col'							=>	GUI::Views::Positioning::Hoo3ColView.name,
			'4col'							=>	GUI::Views::Positioning::Hoo4ColView.name,
			'5col'							=>	GUI::Views::Positioning::Hoo5ColView.name,

			'paddedHorizontal'				=>	GUI::Views::Unsorted::HooPaddedHorizontalList2View.name,

			'spacedVerticalList'			=>	GUI::Views::Unsorted::HooSpacedVerticalList.name,
			'spacedCellList'				=>	GUI::Views::Unsorted::HooSpacedCellList.name,

			# for drawing - forms
			'formButtonSimple'				=> Views::Drawing::Buttons::FormButton::HooFormButtonSimple.name,
			'formButtonToggle'				=> GUI::Views::Drawing::Buttons::FormButton::HooFormButtonToggle.name,

			# for drawing - link buttons
			'divButtonSimple'				=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimple.name,
			'divButtonSimpleDynamicWidth'	=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimpleDynamicWidth.name,

			'divButtonToggle'				=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonToggle.name,
			'divButtonToggleDynamicWidth'	=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth.name,

			'jqueryTestButton'				=> GUI::Views::Drawing::Buttons::Jquery::JqueryButtonTest.name,

			# for Drawing - menus
			'miniInLineMenu'				=> 	GUI::Views::Drawing::Menus::HooMiniInlineMenu.name,

			# for Drawing - menuItems
			'textToggleItem'		=> 	GUI::Views::Drawing::Menus::Items::HooTextToggleItem.name,
			'textLinkItem'			=> 	GUI::Views::Drawing::Menus::Items::HooTextLinkItem.name,

			'simpleBusySpinner'		=>	GUI::Views::Drawing::Other::HooSimpleSpinner.name,
			'simpleTextField'		=>	GUI::Views::Drawing::Other::HooSimpleTextField.name,
			'simpleSlider'			=>	GUI::Views::Drawing::Other::HooSimpleSlider.name,
			'simpleCheckbox'		=>	GUI::Views::Drawing::Other::HooSimpleCheckbox.name,

			'speechBubbleBottomCanvas'	=>	GUI::Views::Drawing::Experiments::HooSpeechBubbleBottomCanvas.name,

			'backgroundImage'		=>	GUI::Views::Unsorted::HooBackgroundImg.name,
			'fixedSizeImage'		=>	GUI::Views::Unsorted::HooFixedSizeImg.name,
			'hoo100PercentImg'		=>	GUI::Views::Unsorted::HooOneHundredPercentImg.name,
			'slidingDoorsPanel1'	=>	GUI::Views::Unsorted::HooSlidingDoorsPanel.name,
			'speechBubblePane'		=>	GUI::Views::Unsorted::HooSlidingDoorsSpeechPanel.name,
			'croppedImg'			=>	GUI::Views::Unsorted::HooCroppedImg.name,
			'inlineTextList'		=>	GUI::Views::Unsorted::HooInlineTextList.name,
			'cuteDropDownMenu'		=>	GUI::Views::Unsorted::HooCuteDropDownMenu.name,

			# Flash Stuff
			'headlessPlayer'		=>	GUI::Views::Flash::HeadlessAudioPlayer.name,
			'headlessRecorder'		=>	GUI::Views::Flash::HeadlessAudioRecorder.name,

			# Audioboo specific
			'followButtonSection'	=>	GUI::Views::Audioboo::FollowButtonSection.name,
			'userDetailsBanner'		=>	GUI::Views::Audioboo::UserDetailsBanner.name,
			'booMainDetails'		=>	GUI::Views::Audioboo::BooMainDetails.name,
			'detailPlayer'			=>	GUI::Views::Audioboo::DetailPlayer.name,
			'adam_detailPlayer'		=>	GUI::Views::Audioboo::AdamDetailPlayer.name,

			'tableHeader'			=> GUI::Views::Audioboo::TableHeader.name,
			'croppedImgWithHeader'	=> GUI::Views::Audioboo::CroppedImgWithHeader.name,
			'tableList'				=> GUI::Views::Audioboo::TableList.name,
			'addComment'			=> GUI::Views::Audioboo::AddComment.name,
			'all_user_comments'		=> GUI::Views::Audioboo::AllUserComments.name,
			'footer'				=> GUI::Views::Audioboo::Footer.name,
			'editBar'				=> GUI::Views::Audioboo::EditBar.name,
			'mastHead'				=> GUI::Views::Audioboo::MastHead.name,

			# for debugging
			'textStyle'				=>	GUI::Views::Debug::HooTextStyle.name,
			'flippyToggleThing'		=>	GUI::Views::Debug::FlippyToggleThing.name,
			'testUploadForm'		=>	GUI::Views::Debug::TestUploadFormView.name,
			'singleWidget'		    =>	GUI::Views::Debug::HooSingleWidgetView.name,
			'widgetResizer'		    =>	GUI::Views::Debug::HooWidgetResizerView.name,
			'blueView'			    =>	GUI::Views::Debug::HooBlueView.name,
			'redView'			    =>	GUI::Views::Debug::HooRedView.name,
			'colorFill'			    =>	GUI::Views::Debug::HooColorFill.name,
			'bigWord'			    =>	GUI::Views::Debug::HooBigWordView.name,

			'cellRenderer'			=>	GUI::Views::Unsorted::HooCellRenderer.name,

			'labeledButton'		    =>	GUI::Views::Unsorted::HooLabeledButton1.name,
			'info1'				    =>	GUI::Views::Unsorted::HooInfoOneView.name,
			'loremIpsum'		    =>	GUI::Views::Unsorted::HooLoremIpsumView.name,
			'loremIpsumTitle'	    =>	GUI::Views::Unsorted::HooLoremIpsumTitleView.name,
			'pullQuote1'		    =>	GUI::Views::Unsorted::HooPullQuoteOneView.name,
			'list1'				    =>	GUI::Views::Unsorted::HooListOneView.name,
			'horizontalList1'	    =>	GUI::Views::Unsorted::HooHorizontalListOneView.name,
			'textList1'			    =>	GUI::Views::Unsorted::HooTextListView.name,
			'gridView'			    =>	GUI::Views::Unsorted::HooGridOneView.name,
		}

		def self.widgets
			@@widgets
		end

		def self.widgetNames
			@@widgets.keys
		end

		def self.widgetPaths
			@@widgets.values
		end

		def self.widgetClass( name )

			widgetName = @@widgets[name]
			if(widgetName==nil)
				raise "Widget "+name+" not found!"
			end
			widgetName.constantize
		end


		@@cells = {
			'list1'				=>	GUI::Cells::HooListOneCell.name,
			'horizontalList1'	=>	GUI::Cells::HooHorizontalListOneCell.name,
			'sparseBooCell'	    =>	GUI::Cells::HooSparseBooCell.name,
			'hoo_user_comment_cell' => GUI::Cells::HooUserCommentCell.name,
			'actionButton1' 	=> GUI::Cells::HooActionButton1Cell.name,
		}

		def self.cellClass( name )

			cellName = @@cells[name]
			if(cellName==nil)
				raise "Cell "+name+" not found!"
			end
			cellName.constantize
		end

	end
end

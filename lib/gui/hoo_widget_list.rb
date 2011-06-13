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

			# for drawing - forms
			'formButtonSimple'				=>	GUI::Views::Drawing::Buttons::FormButton::HooFormButtonSimple.name,
			'formButtonToggle'				=>	GUI::Views::Drawing::Buttons::FormButton::HooFormButtonToggle.name,

			# for drawing - link buttons
			'divButtonSimple'				=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimple.name,
			'divButtonSimpleDynamicWidth'	=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimpleDynamicWidth.name,

			'divButtonToggle'				=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonToggle.name,
			'divButtonToggleDynamicWidth'	=> 	GUI::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth.name,

			'jqueryTestButton'				=>	GUI::Views::Drawing::Buttons::Jquery::JqueryButtonTest.name,

			# for Drawing - menus
			'miniInLineMenu'				=> 	GUI::Views::Drawing::Menus::HooMiniInlineMenu.name,

			# for Drawing - player
			'simpleTimeDisplay'				=>	GUI::Views::Drawing::Player::HooSimpleTimeDisplay.name,
			'simpleSlider'					=>	GUI::Views::Drawing::Player::HooSimpleSlider.name,
			'playPauseButton'				=>	GUI::Views::Drawing::Player::HooPlayPauseButton.name,
			'radialProgress'				=>	GUI::Views::Drawing::Player::HooRadialProgress.name,
			'smallPlayerPlayButton'			=>	GUI::Views::Drawing::Player::HooSmallPlayerPlayButton.name,

			# for Drawing - menuItems
			'textToggleItem'		=> 	GUI::Views::Drawing::Menus::Items::HooTextToggleItem.name,
			'textLinkItem'			=> 	GUI::Views::Drawing::Menus::Items::HooTextLinkItem.name,

			'simpleBusySpinner'		=>	GUI::Views::Drawing::Other::HooSimpleSpinner.name,
			'simpleTextField'		=>	GUI::Views::Drawing::Other::HooSimpleTextField.name,
			'simpleCheckbox'		=>	GUI::Views::Drawing::Other::HooSimpleCheckbox.name,
			'canvas'				=>	GUI::Views::Drawing::Other::HooCanvas.name,

			'speechBubbleBottomCanvas'	=>	GUI::Views::Drawing::Experiments::HooSpeechBubbleBottomCanvas.name,
			'roundedTriangle'			=>	GUI::Views::Drawing::Experiments::RoundedTriangle.name,

			# Flash Stuff
			'headlessPlayer'		=>	GUI::Views::Flash::HeadlessAudioPlayer.name,
			'headlessRecorder'		=>	GUI::Views::Flash::HeadlessAudioRecorder.name,
			'flashDetailPlayer'		=>	GUI::Views::Flash::FlashDetailAudioPlayer.name,
			'detailPlayer'			=>	GUI::Views::Flash::DetailPlayer.name,
			'adam_detailPlayer'		=>	GUI::Views::Flash::AdamDetailPlayer.name,

			# Audioboo specific
			'followButtonSection'	=>	GUI::Views::Audioboo::FollowButtonSection.name,
			'userDetailsBanner'		=>	GUI::Views::Audioboo::UserDetailsBanner.name,
			'booMainDetails'		=>	GUI::Views::Audioboo::BooMainDetails.name,
			'tableHeader'			=> GUI::Views::Audioboo::TableHeader.name,
			'croppedImgWithHeader'	=> GUI::Views::Audioboo::CroppedImgWithHeader.name,
			'tableList'				=> GUI::Views::Audioboo::TableList.name,
			'addComment'			=> GUI::Views::Audioboo::AddComment.name,
			'all_user_comments'		=> GUI::Views::Audioboo::AllUserComments.name,
			'footer'				=> GUI::Views::Audioboo::Footer.name,
			'editBar'				=> GUI::Views::Audioboo::EditBar.name,
			'mastHead'				=> GUI::Views::Audioboo::MastHead.name,

			# for debugging
			'cellRenderer'			=>	GUI::Views::Debug::HooCellRenderer.name,
			'mockPlayer'			=>	GUI::Views::Debug::MockPlayer.name,
			'textStyle'				=>	GUI::Views::Debug::HooTextStyle.name,
			'flippyToggleThing'		=>	GUI::Views::Debug::FlippyToggleThing.name,
			'testUploadForm'		=>	GUI::Views::Debug::TestUploadFormView.name,
			'singleWidget'		    =>	GUI::Views::Debug::HooSingleWidgetView.name,
			'widgetResizer'		    =>	GUI::Views::Debug::HooWidgetResizerView.name,
			'blueView'			    =>	GUI::Views::Debug::HooBlueView.name,
			'redView'			    =>	GUI::Views::Debug::HooRedView.name,
			'colorFill'			    =>	GUI::Views::Debug::HooColorFill.name,
			'bigWord'			    =>	GUI::Views::Debug::HooBigWordView.name,
			'debugTextInput'		=>	GUI::Views::Debug::HooDebugTextInput.name,
			'flashresizetest'		=>	GUI::Views::Debug::FlashResizeTest.name,
			'flashsharedelementtest'	=> GUI::Views::Debug::FlashSharedElementTest.name,
			'flashsharedelement'	=> GUI::Views::Debug::FlashSharedElement.name,

			# Lists
			'textList1'			    =>	GUI::Views::Lists::HooTextListView.name,
			'spacedVerticalList'	=>	GUI::Views::Lists::HooSpacedVerticalList.name,
			'list1'				    =>	GUI::Views::Lists::HooListOneView.name,
			'inlineTextList'		=>	GUI::Views::Lists::HooInlineTextList.name,
			'horizontalList1'	    =>	GUI::Views::Lists::HooHorizontalListOneView.name,
			'spacedCellList'		=>	GUI::Views::Lists::HooSpacedCellList.name,
			'paddedHorizontal'		=>	GUI::Views::Lists::HooPaddedHorizontalList2View.name,

			# Sproutcore
			'sc_todos'				=> GUI::Views::Sproutcore::ScTodos.name,
			'sc_button'				=> GUI::Views::Sproutcore::ScButton.name,
			'sc_checkbox'			=> GUI::Views::Sproutcore::ScCheckbox.name,
			'sc_textfield'			=> GUI::Views::Sproutcore::ScTextfield.name,

			# Unsorted
			'labeledButton'		    =>	GUI::Views::Unsorted::HooLabeledButton1.name,
			'info1'				    =>	GUI::Views::Unsorted::HooInfoOneView.name,
			'loremIpsum'		    =>	GUI::Views::Unsorted::HooLoremIpsumView.name,
			'loremIpsumTitle'	    =>	GUI::Views::Unsorted::HooLoremIpsumTitleView.name,
			'pullQuote1'		    =>	GUI::Views::Unsorted::HooPullQuoteOneView.name,
			'gridView'			    =>	GUI::Views::Unsorted::HooGridOneView.name,
			'backgroundImage'		=>	GUI::Views::Unsorted::HooBackgroundImg.name,
			'fixedSizeImage'		=>	GUI::Views::Unsorted::HooFixedSizeImg.name,
			'hoo100PercentImg'		=>	GUI::Views::Unsorted::HooOneHundredPercentImg.name,
			'slidingDoorsPanel1'	=>	GUI::Views::Unsorted::HooSlidingDoorsPanel.name,
			'speechBubblePane'		=>	GUI::Views::Unsorted::HooSlidingDoorsSpeechPanel.name,
			'croppedImg'			=>	GUI::Views::Unsorted::HooCroppedImg.name,
			'cuteDropDownMenu'		=>	GUI::Views::Unsorted::HooCuteDropDownMenu.name,

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

			'flashReplaceTestCell' 	=> GUI::Cells::FlashReplaceTestCell.name,
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

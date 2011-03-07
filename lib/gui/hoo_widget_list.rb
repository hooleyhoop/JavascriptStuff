module GUI
	class HooWidgetList

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
			'verticalSplitView'     =>	GUI::Views::HooVerticalSplitView.name,
			'horizontalSplitView'   =>	GUI::Views::HooHorizontalSplitView.name,
			'spacerView'		    =>	GUI::Views::HooSpacerView.name,
			'relativeOffsetView'    =>	GUI::Views::HooRelativeOffsetView.name,
			'spacedVerticalList'    =>	GUI::Views::HooSpacedVerticalList.name,
			'twoElasticColsFixedGutter' =>	GUI::Views::HooTwoElasticColsFixedGutter.name,
			'spacedCellList'		=>	GUI::Views::HooSpacedCellList.name,

			# These have a percentage spacing, not what i want!
			'2col_percent_padded'					=>	GUI::Views::Positioning::Hoo2ColPercentPaddedView.name,
			'3col_percent_padded'					=>	GUI::Views::Positioning::Hoo3ColPercentPaddedView.name,
			'4col_percent_padded'					=>	GUI::Views::Positioning::Hoo4ColPercentPaddedView.name,
			'5col_percent_padded'					=>	GUI::Views::Positioning::Hoo5ColPercentPaddedView.name,

			# What i want is fixed space
			'2col'					=>	GUI::Views::Positioning::Hoo2ColView.name,
			'3col'					=>	GUI::Views::Positioning::Hoo3ColView.name,
			'4col'					=>	GUI::Views::Positioning::Hoo4ColView.name,
			'5col'					=>	GUI::Views::Positioning::Hoo5ColView.name,

			'paddedHorizontal'		=>	GUI::Views::Positioning::HooPaddedHorizontalList2View.name,

			# for drawing - forms
			'formButtonSimple'		=>	GUI::Views::Drawing::Buttons::HooFormButtonSimple.name,
			'formButtonToggle'		=>	GUI::Views::Drawing::Buttons::HooFormButtonToggle.name,

			# for drawing - link buttons
			'divButtonSimple'		=> 	GUI::Views::Drawing::Buttons::HooDivButtonSimple.name,
			'divButtonToggle'		=> 	GUI::Views::Drawing::Buttons::HooDivButtonToggle.name,

			'simpleBusySpinner'		=>	GUI::Views::Drawing::Other::HooSimpleSpinner.name,
			'simpleTextField'		=>	GUI::Views::Drawing::Other::HooSimpleTextField.name,
			'simpleSlider'			=>	GUI::Views::Drawing::Other::HooSimpleSlider.name,

			'backgroundImage'		=>	GUI::Views::HooBackgroundImg.name,
			'fixedSizeImage'		=>	GUI::Views::HooFixedSizeImg.name,
			'hoo100PercentImg'		=>	GUI::Views::HooOneHundredPercentImg.name,
			'slidingDoorsPanel1'	=>	GUI::Views::HooSlidingDoorsPanel.name,
			'speechBubblePane'		=>	GUI::Views::HooSlidingDoorsSpeechPanel.name,
			'croppedImg'			=>	GUI::Views::HooCroppedImg.name,
			'inlineTextList'		=>	GUI::Views::HooInlineTextList.name,
			'cuteDropDownMenu'		=>	GUI::Views::HooCuteDropDownMenu.name,

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
			'flippyToggleThing'		=>	GUI::Views::Debug::FlippyToggleThing.name,
			'testUploadForm'		=>	GUI::Views::Debug::TestUploadFormView.name,
			'singleWidget'		    =>	GUI::Views::HooSingleWidgetView.name,
			'cellRenderer'			=>	GUI::Views::HooCellRenderer.name,

			'labeledButton'		    =>	GUI::Views::HooLabeledButton1.name,
			'blueView'			    =>	GUI::Views::HooBlueView.name,
			'redView'			    =>	GUI::Views::HooRedView.name,
			'colorFill'			    =>	GUI::Views::HooColorFill.name,
			'info1'				    =>	GUI::Views::HooInfoOneView.name,
			'loremIpsum'		    =>	GUI::Views::HooLoremIpsumView.name,
			'loremIpsumTitle'	    =>	GUI::Views::HooLoremIpsumTitleView.name,
			'pullQuote1'		    =>	GUI::Views::HooPullQuoteOneView.name,
			'list1'				    =>	GUI::Views::HooListOneView.name,
			'horizontalList1'	    =>	GUI::Views::HooHorizontalListOneView.name,
			'textList1'			    =>	GUI::Views::HooTextListView.name,
			'gridView'			    =>	GUI::Views::HooGridOneView.name,
			'bigWord'			    =>	GUI::Views::HooBigWordView.name,
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

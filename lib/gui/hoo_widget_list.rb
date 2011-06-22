module Gui
	class HooWidgetList

		# Can't get this type of thing to work
		#require "gui/views/drawing.rb"

		@@layouts = {}
		@@widgets = {}
		@@cells = {}

		#	'fixedWidthSingleCol'			=>	Gui::Layouts::HooFixedSingleColView.name,
		#	'elasticColRight'				=>	Gui::Layouts::HooElasticColRightView.name,
		#	'elasticColLeft'				=>	Gui::Layouts::HooElasticColLeftView.name,
		#	'elasticColBoth'				=>	Gui::Layouts::HooElasticColBothView.name
		#}

		# To construct the widget list at runtime
		def self.registerWidget( widget )
			if registered? widget
				Rails.logger.warn "Widget #{widget.name} already registered"
			else
				@@widgets[widget.dslName] = widget
				puts "#{widget.dslName} added to widget list"
			end
		end

		def self.registered?( widget )
			@@widgets.include? widget.dslName
		end

		def self.layoutClass( name )

			layoutName = @@layouts[name]
			if(layoutName==nil)
				raise "Layout "+name+" not found!"
			end
			layoutName.constantize
		end

		#@@widgets = {

			# for positioning
		#	'verticalSplitView'				=>	Gui::Views::Positioning::HooVerticalSplitView.name,
		#	'horizontalSplitView'			=>	Gui::Views::Positioning::HooHorizontalSplitView.name,
		#	'spacerView'					=>	Gui::Views::Positioning::HooSpacerView.name,
		#	'relativeOffsetView'			=>	Gui::Views::Positioning::HooRelativeOffsetView.name,
		#	'twoElasticColsFixedGutter'		=>	Gui::Views::Positioning::HooTwoElasticColsFixedGutter.name,

			# These have a percentage spacing, not what i want!
		#	'2col_percent_padded'			=>	Gui::Views::Positioning::Hoo2ColPercentPaddedView.name,
		#	'3col_percent_padded'			=>	Gui::Views::Positioning::Hoo3ColPercentPaddedView.name,
		#	'4col_percent_padded'			=>	Gui::Views::Positioning::Hoo4ColPercentPaddedView.name,
		#	'5col_percent_padded'			=>	Gui::Views::Positioning::Hoo5ColPercentPaddedView.name,

			# What i want is fixed space
		#	'2col'							=>	Gui::Views::Positioning::Hoo2ColView.name,
		#	'3col'							=>	Gui::Views::Positioning::Hoo3ColView.name,
		#	'4col'							=>	Gui::Views::Positioning::Hoo4ColView.name,
		#	'5col'							=>	Gui::Views::Positioning::Hoo5ColView.name,

			# for drawing - forms
		#	'formButtonSimple'				=>	Gui::Views::Drawing::Buttons::FormButton::HooFormButtonSimple.name,
		#	'formButtonToggle'				=>	Gui::Views::Drawing::Buttons::FormButton::HooFormButtonToggle.name,

		#	# for drawing - link buttons
		#	'divButtonSimple'				=>	Gui::Views::Drawing::Buttons::DivButton::HooDivButtonSimple.name,
		#	'divButtonSimpleDynamicWidth'	=>	Gui::Views::Drawing::Buttons::DivButton::HooDivButtonSimpleDynamicWidth.name,

		#	'divButtonToggle'				=>	Gui::Views::Drawing::Buttons::DivButton::HooDivButtonToggle.name,
		#	'divButtonToggleDynamicWidth'	=>	Gui::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth.name,
#
			#'jqueryTestButton'				=>	Gui::Views::Drawing::Buttons::Jquery::JqueryButtonTest.name,

			# for Drawing - menus
			#'miniInLineMenu'				=>	Gui::Views::Drawing::Menus::HooMiniInlineMenu.name,

			# for Drawing - player
			#'simpleTimeDisplay'				=>	Gui::Views::Drawing::Player::HooSimpleTimeDisplay.name,
			#'simpleSlider'					=>	Gui::Views::Drawing::Player::HooSimpleSlider.name,
			#'playPauseButton'				=>	Gui::Views::Drawing::Player::HooPlayPauseButton.name,
			#'radialProgress'				=>	Gui::Views::Drawing::Player::HooRadialProgress.name,
			#'smallPlayerPlayButton'			=>	Gui::Views::Drawing::Player::HooSmallPlayerPlayButton.name,

			# for Drawing - menuItems
			#'textToggleItem'				=>	Gui::Views::Drawing::Menus::Items::HooTextToggleItem.name,
			#'textLinkItem'					=>	Gui::Views::Drawing::Menus::Items::HooTextLinkItem.name,

			#'simpleBusySpinner'				=>	Gui::Views::Drawing::Other::HooSimpleSpinner.name,
			#'simpleTextField'				=>	Gui::Views::Drawing::Other::HooSimpleTextField.name,
			#'simpleCheckbox'				=>	Gui::Views::Drawing::Other::HooSimpleCheckbox.name,
			#'canvas'						=>	Gui::Views::Drawing::Other::HooCanvas.name,

			#'speechBubbleBottomCanvas'		=>	Gui::Views::Drawing::Experiments::HooSpeechBubbleBottomCanvas.name,
			#'roundedTriangle'				=>	Gui::Views::Drawing::Experiments::RoundedTriangle.name,
#
			# For Drawing Images
			#'croppedImg'					=>	Gui::Views::Drawing::Images::HooCroppedImg.name,
			#'backgroundImage'				=>	Gui::Views::Drawing::Images::HooBackgroundImg.name,
			#'fixedSizeImage'				=>	Gui::Views::Drawing::Images::HooFixedSizeImg.name,
			#'hoo100PercentImg'				=>	Gui::Views::Drawing::Images::HooOneHundredPercentImg.name,

			# Flash Stuff
			#'headlessPlayer'				=>	Gui::Views::Flash::HeadlessAudioPlayer.name,
			#'headlessRecorder'				=>	Gui::Views::Flash::HeadlessAudioRecorder.name,
			#'flashDetailPlayer'				=>	Gui::Views::Flash::FlashDetailAudioPlayer.name,
			#'detailPlayer'					=>	Gui::Views::Flash::DetailPlayer.name,
			#'adam_detailPlayer'				=>	Gui::Views::Flash::AdamDetailPlayer.name,

			# Audioboo specific
			#'followButtonSection'			=>	Gui::Views::Audioboo::FollowButtonSection.name,
			#'userDetailsBanner'				=>	Gui::Views::Audioboo::UserDetailsBanner.name,
			#'booMainDetails'				=>	Gui::Views::Audioboo::BooMainDetails.name,
			#'tableHeader'					=>	Gui::Views::Audioboo::TableHeader.name,
			#'croppedImgWithHeader'			=>	Gui::Views::Audioboo::CroppedImgWithHeader.name,
			#'tableList'						=>	Gui::Views::Audioboo::TableList.name,
			#'addComment'					=>	Gui::Views::Audioboo::AddComment.name,
			#'all_user_comments'				=>	Gui::Views::Audioboo::AllUserComments.name,
			#'footer'						=>	Gui::Views::Audioboo::Footer.name,
			#'editBar'						=>	Gui::Views::Audioboo::EditBar.name,
			#'mastHead'						=>	Gui::Views::Audioboo::MastHead.name,

			# for debugging
			#'cellRenderer'					=>	Gui::Views::Debug::HooCellRenderer.name,
			#'mockPlayer'					=>	Gui::Views::Debug::MockPlayer.name,
			#'flippyToggleThing'				=>	Gui::Views::Debug::FlippyToggleThing.name,
			#'testUploadForm'				=>	Gui::Views::Debug::TestUploadFormView.name,
			#'debugTextInput'				=>	Gui::Views::Debug::HooDebugTextInput.name,

			# basic
			#'blueView'			    		=>	Gui::Views::Debug::Basic::HooBlueView.name,
			#'redView'			    		=>	Gui::Views::Debug::Basic::HooRedView.name,
			#'colorFill'			    		=>	Gui::Views::Debug::Basic::HooColorFill.name,
			#'textStyle'						=>	Gui::Views::Debug::Basic::HooTextStyle.name,
			#'bigWord'			    		=>	Gui::Views::Debug::Basic::HooBigWordView.name,

			# widget_preview
			#'singleWidget'		   			=>	Gui::Views::Debug::WidgetPreview::HooSingleWidgetView.name,
			#'widgetResizer'		    		=>	Gui::Views::Debug::WidgetPreview::HooWidgetResizerView.name,

			# cropped_image
			#'canvasimgresizetest'			=>	Gui::Views::Debug::CroppedImage::CanvasImgResizeTest.name,
			#'flashresizetest'				=>	Gui::Views::Debug::CroppedImage::FlashResizeTest.name,

			# moving_a_shared_flash
			#'flashsharedelementtest'		=>	Gui::Views::Debug::MovingASharedFlash::FlashSharedElementTest.name,
			#'flashsharedelement'			=>	Gui::Views::Debug::MovingASharedFlash::FlashSharedElement.name,

			# moving_a_shared_headless_flash
			#'beepertestflash'						=>	Gui::Views::Debug::MovingASharedHeadlessFlash::BeeperTestFlash.name,
			#'multiplebeepertestflash'				=>	Gui::Views::Debug::MovingASharedHeadlessFlash::MultipleBeeperTestFlash.name,
			#'headless_mp3_test_flash'				=>	Gui::Views::Debug::MovingASharedHeadlessFlash::HeadlessMp3TestFlash.name,
			#'multiple_headless_mp3_test_flash'		=>	Gui::Views::Debug::MovingASharedHeadlessFlash::MultipleHeadlessMp3TestFlash.name,
			#'small_player_mp3_test_flash'			=>	Gui::Views::Debug::MovingASharedHeadlessFlash::SmallPlayerMp3TestFlash.name,
			#'multiple_small_player_mp3_test_flash'	=>	Gui::Views::Debug::MovingASharedHeadlessFlash::MultipleSmallPlayerMp3TestFlash.name,

			#'beepertesthtml5'				=>	Gui::Views::Debug::MovingASharedHeadlessFlash::BeeperTestHTML5.name,
			#'multiplebeepertesthtml5'		=>	Gui::Views::Debug::MovingASharedHeadlessFlash::MultipleBeeperTestHTML5.name,

			#'linkwithinlinetemplate'		=>	Gui::Views::Debug::SCTemplateTests::LinkWithInlineTemplate.name,
			#'linkwithmaybetemplate'			=>	Gui::Views::Debug::SCTemplateTests::LinkWithMaybeTemplate.name,
			#'dynamic_value_test'			=>	Gui::Views::Debug::SCTemplateTests::DynamicValueTest.name,

			# unused


			# Lists
			#'textList1'			    		=>	Gui::Views::Lists::HooTextListView.name,
			#'spacedVerticalList'			=>	Gui::Views::Lists::HooSpacedVerticalList.name,
			#'list1'				    		=>	Gui::Views::Lists::HooListOneView.name,
			#'inlineTextList'				=>	Gui::Views::Lists::HooInlineTextList.name,
			#'horizontalList1'	    		=>	Gui::Views::Lists::HooHorizontalListOneView.name,
			#'spacedCellList'				=>	Gui::Views::Lists::HooSpacedCellList.name,
			#'paddedHorizontal'				=>	Gui::Views::Lists::HooPaddedHorizontalList2View.name,

			# Sproutcore
			#'sc_todos'						=>	Gui::Views::Sproutcore::ScTodos.name,
			#'sc_button'						=>	Gui::Views::Sproutcore::ScButton.name,
			#'sc_checkbox'					=>	Gui::Views::Sproutcore::ScCheckbox.name,
			#'sc_textfield'					=>	Gui::Views::Sproutcore::ScTextfield.name,

			# Unsorted
			#'labeledButton'		    		=>	Gui::Views::Unsorted::HooLabeledButton1.name,
			#'info1'				   			=>	Gui::Views::Unsorted::HooInfoOneView.name,
			#'loremIpsum'		    		=>	Gui::Views::Unsorted::HooLoremIpsumView.name,
			#'loremIpsumTitle'	    		=>	Gui::Views::Unsorted::HooLoremIpsumTitleView.name,
			#'pullQuote1'		    		=>	Gui::Views::Unsorted::HooPullQuoteOneView.name,
		#	'gridView'			    		=>	Gui::Views::Unsorted::HooGridOneView.name,
		#	'slidingDoorsPanel1'			=>	Gui::Views::Unsorted::HooSlidingDoorsPanel.name,
		#	'speechBubblePane'				=>	Gui::Views::Unsorted::HooSlidingDoorsSpeechPanel.name,
		#	'cuteDropDownMenu'				=>	Gui::Views::Unsorted::HooCuteDropDownMenu.name,
		#}




		#def self.widgets
		#	@@widgets
		#end

		#def self.widgetNames
		#	@@widgets.keys
		#end

		#def self.widgetPaths
		#	@@widgets.values
		#end

		def self.scanViewDir()
			thisDir = File.dirname(__FILE__)
			# just child directories
			Dir.glob( "#{thisDir}/*" ).select do |subdir|
				# recursive .rb files
				Dir.glob( "#{subdir}/**/*.rb" ).each do |f|
					f.sub! "#{Rails.root}/lib/", ''
					f.sub! ".rb", ''
					# thisClassName = f.classify - NB! classify changes plural to singular
					thisClassName = f.to_s.sub(/.*\./, '').camelize
					#puts "> Found class #{f} - #{thisClassName}"
					thisClass = thisClassName.constantize()
					if thisClass.respond_to?( 'dslName' )
						self.registerWidget( thisClass )
					end
				end
			end
		end

		@@hasScanned = false
		def self.widgetClass( name )

			#first time thru build the widget list
			unless @@hasScanned
				puts "scanning"
				self.scanViewDir()
				@@hasScanned = true
			end
			foundClass = @@widgets[name]
			if(foundClass==nil)
				raise "Widget "+name+" not found!"
			end
			return foundClass
		end


		#@@cells = {
		#	'list1'					=>	Gui::Cells::HooListOneCell.name,
		#	'horizontalList1'		=>	Gui::Cells::HooHorizontalListOneCell.name,
		#	'sparseBooCell'	    	=>	Gui::Cells::HooSparseBooCell.name,
		#	'hoo_user_comment_cell' =>	Gui::Cells::HooUserCommentCell.name,
		#	'actionButton1' 		=>	Gui::Cells::HooActionButton1Cell.name,
		#	'flashReplaceTestCell' 	=>	Gui::Cells::FlashReplaceTestCell.name,
		#}

		def self.cellClass( name )
			cellName = @@cells[name]
			if(cellName==nil)
				raise "Cell "+name+" not found!"
			end
			cellName.constantize
		end

	end
end

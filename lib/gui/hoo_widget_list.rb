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
            'spacedCellList'         =>	GUI::Views::HooSpacedCellList.name,

		    # for drawing
            'backgroundImage'       =>	GUI::Views::HooBackgroundImg.name,
            'fixedSizeImage'        =>	GUI::Views::HooFixedSizeImg.name,
            'hoo100PercentImg'      =>	GUI::Views::HooOneHundredPercentImg.name,
			'slidingDoorsPanel1'    =>	GUI::Views::HooSlidingDoorsPanel.name,
			'speechBubblePane'      =>	GUI::Views::HooSlidingDoorsSpeechPanel.name,
            'singlebuttonForm'      =>	GUI::Views::HooSingleButtonForm.name,
            'croppedImg'            =>	GUI::Views::HooCroppedImg.name,
            'inlineTextList'        =>  GUI::Views::HooInlineTextList.name,

            # Audioboo specific
            'followButtonSection'   =>	GUI::Views::Audioboo::FollowButtonSection.name,
            'userDetailsBanner'     => GUI::Views::Audioboo::UserDetailsBanner.name,
            'booMainDetails'        => GUI::Views::Audioboo::BooMainDetails.name,
            'detailPlayer'          => GUI::Views::Audioboo::DetailPlayer.name,
            'tableHeader'           => GUI::Views::Audioboo::TableHeader.name,
            'croppedImgWithHeader'  =>	GUI::Views::Audioboo::CroppedImgWithHeader.name,
            'tableList'             =>	GUI::Views::Audioboo::TableList.name,

		    # for debugging
			'singleWidget'		    =>	GUI::Views::HooSingleWidgetView.name,

			'labeledButton'		    =>	GUI::Views::HooLabeledButton1.name,
			'blueView'			    =>	GUI::Views::HooBlueView.name,
			'redView'			    =>	GUI::Views::HooRedView.name,
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

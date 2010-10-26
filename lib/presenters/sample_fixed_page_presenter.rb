module Presenters
	class SampleFixedPagePresenter < HooPresenter

		def initialize( controller, configuration )
		
			super( controller )
			
			
			@colView = GUI::HooFixedSingleColView.new( {:sideBarPxWidth=>200} );
				
			#
			# All text areas top padding should be line-height - textHeight
			#
						
			#construct the header
			typeSize = 13;
			lineHeight = 15;
			topOffset = lineHeight - typeSize;
		
			headerSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			headerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.header = headerSpacer;
			
			#construct the main panel
			mainColSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			
			subSpacer1 = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			subSpacer1.addSubView( GUI::HooLoremIpsumView.new() );
			
			# margins here will collapse
			
			subSpacer2 = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			subSpacer2.addSubView( GUI::HooLoremIpsumTitleView.new() );
			
			subSpacer3 = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			subSpacer3.addSubView( GUI::HooLoremIpsumView.new() );
			
	
			mainColSpacer.addSubView( subSpacer1 );
			mainColSpacer.addSubView( subSpacer2 );
			mainColSpacer.addSubView( subSpacer3 );
			
			info1 = GUI::HooInfoOneView.new()
			info1.setupDebugFixture
			mainColSpacer.addSubView( info1 );
			
			pullQuote = GUI::HooPullQuoteOneView.new();
			pullQuote.text = "Hello!"
			pullQuote.setupDebugFixture
			mainColSpacer.addSubView( pullQuote );
			
			info2 = GUI::HooInfoOneView.new()
			info2.setupDebugFixture			
			mainColSpacer.addSubView( info2 );
		
			@colView.mainColumn = mainColSpacer;
			
			#construct the footer
			footerSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			footerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.footer = footerSpacer;

			#GUI::HooRoundedPanelPanel.new()

			@window.contentView.addSubView( @colView );
		end


	
	end
end

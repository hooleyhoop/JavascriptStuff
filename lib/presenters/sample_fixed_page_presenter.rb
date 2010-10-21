module Presenters
	class SampleFixedPagePresenter < HooPresenter

		def initialize( controller, configuration )
		
			super( controller )
			
			@colView = nil;
			
			# Sidebar on the right
			if configuration == 0
				@colView = GUI::HooFixedSingleColView.new( {:sideBarPxWidth=>200} );
				
			# Sidebar on the left
			elsif configuration == 1
				#@colView = GUI::HooElasticColLeftView.new( {:sideBarPxWidth=>200} );
											
				#construct the sidebar
				#sideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 10 );
				#sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				#@colView.sidebar = sideBarSpacer;
			
			# Sidebar on both sides
			else
				#@colView = GUI::HooElasticColBothView.new( {:leftSideBarPxWidth=>200, :rightSideBarPxWidth=>200} );
				
				#construct the left sidebar
				#leftSideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 10 );
				#leftSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				#@colView.leftSidebar = leftSideBarSpacer;
				
				#construct the right sidebar
				#rightSideBarSpacer = GUI::HooSpacerView.new( 0, 10, 0, 0 );
				#rightSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				#@colView.rightSidebar = rightSideBarSpacer;
			
			end
						
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
			mainColSpacer.addSubView( GUI::HooInfoOne.new() );
			mainColSpacer.addSubView( GUI::HooInfoOne.new() );
		
			@colView.mainColumn = mainColSpacer;
			
			#construct the footer
			footerSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			footerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.footer = footerSpacer;

			#GUI::HooRoundedPanelPanel.new()

			@window.addSubView( @colView );
		end


	
	end
end

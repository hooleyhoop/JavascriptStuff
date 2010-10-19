module Presenters
	class SampleElasticPagePresenter < HooPresenter

		def initialize( controller, configuration )
		
			super( controller )
			
			@colView = nil;
			
			# Sidebar on the right
			if configuration == 0
				@colView = GUI::HooElasticColRightView.new( {:sideBarPxWidth=>200} );
				
				#construct the sidebar
				sideBarSpacer = GUI::HooSpacerView.new( 0, 10, 0, 0 );
				sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;
			
			# Sidebar on the left
			elsif configuration == 1
				@colView = GUI::HooElasticColLeftView.new( {:sideBarPxWidth=>200} );
											
				#construct the sidebar
				sideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 10 );
				sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;
			
			# Sidebar on both sides
			else
				@colView = GUI::HooElasticColBothView.new( {:sideBarPxWidth=>200} );
				
				#construct the left sidebar
				leftSideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 10 );
				leftSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.leftSidebar = leftSideBarSpacer;
				
				#construct the right sidebar
				rightSideBarSpacer = GUI::HooSpacerView.new( 0, 10, 0, 0 );
				rightSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.rightSidebar = rightSideBarSpacer;
			
			end
						
			#construct the header
			headerSpacer = GUI::HooSpacerView.new( 0, 0, 10, 0 );
			headerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.header = headerSpacer;
			
			#construct the main panel
			mainColSpacer = GUI::HooSpacerView.new( 0, 10, 0, 10 );
			mainColSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.mainColumn = mainColSpacer;
			
			#construct the footer
			footerSpacer = GUI::HooSpacerView.new( 10, 0, 10, 0 );
			footerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.footer = footerSpacer;

			#GUI::HooRoundedPanelPanel.new()

			@window.addSubView( @colView );
		end

		def drawPage()
			@window.drawNow( @controller );
		end

	
	end
end

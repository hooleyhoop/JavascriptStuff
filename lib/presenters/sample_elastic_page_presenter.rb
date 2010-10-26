module Presenters
	class SampleElasticPagePresenter < HooPresenter

		def initialize( controller, configuration )
		
			super( controller )
			
			@colView = nil;
						
			# Sidebar on the right
			if configuration == 0
				@colView = GUI::HooElasticColRightView.new( {:sideBarPxWidth=>200} );
				
				#construct the sidebar
				sideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
				sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;
			
			# Sidebar on the left
			elsif configuration == 1
				@colView = GUI::HooElasticColLeftView.new( {:sideBarPxWidth=>200} );
											
				#construct the sidebar
				sideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
				sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;
			
			# Sidebar on both sides
			else
				@colView = GUI::HooElasticColBothView.new( {:leftSideBarPxWidth=>200, :rightSideBarPxWidth=>200} );
				
				#construct the left sidebar
				leftSideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
				leftSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.leftSidebar = leftSideBarSpacer;
				
				#construct the right sidebar
				rightSideBarSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
				rightSideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
				@colView.rightSidebar = rightSideBarSpacer;
			
			end
						
			#construct the header
			headerSpacer1 = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			headerSpacer1.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.fullWidthHeader = headerSpacer1;
			
			headerSpacer2 = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			headerSpacer2.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.elasticHeader = headerSpacer2;			
			
			#construct the main panel
			mainColSpacer = GUI::HooSpacerView.new( 0, 0, 0, 0 );
			mainColSpacer.addSubView( GUI::HooLoremIpsumView.new() );
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

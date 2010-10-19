module Presenters
	class SampleElasticPagePresenter < HooPresenter

		def initialize( controller )
		
			super( controller )
			
			@colView = GUI::HooElasticColRightView.new( {:sideBarPxWidth=>200} );

			#GUI::HooRoundedPanelPanel.new()
			
			
			#construct the header
			headerSpacer = GUI::HooSpacerView.new( 0, 0, 10, 0 );
			headerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.header = headerSpacer;
			
			#construct the main panel
			mainColSpacer = GUI::HooSpacerView.new( 0, 10, 0, 10 );
			mainColSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.mainColumn = mainColSpacer;
			
			#construct the sidebar
			sideBarSpacer = GUI::HooSpacerView.new( 0, 10, 0, 0 );
			sideBarSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.sidebar = sideBarSpacer;
			
			#construct the footer
			footerSpacer = GUI::HooSpacerView.new( 10, 0, 10, 0 );
			footerSpacer.addSubView( GUI::HooLoremIpsumView.new() );
			@colView.footer = footerSpacer;

			@window.addSubView( @colView );
		end

		def drawPage()
			@window.drawNow( @controller );
		end

	
	end
end

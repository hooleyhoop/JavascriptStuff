module Presenters
	class SampleElasticPagePresenter < HooPresenter

		def initialize( controller, configuration )

			super( controller )

			@colView = nil;

			spacerView 			= widgetClass('spacerView');
			loremIpsumView 		= widgetClass('loremIpsum');

			# Sidebar on the right
			if configuration == 0

				@colView = layoutClass('elasticColRight').new( {:sideBarPxWidth=>200} );

				#construct the sidebar
				sideBarSpacer = spacerView.new( 0, 0, 0, 0 );
				sideBarSpacer.addSubView( loremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;

			# Sidebar on the left
			elsif configuration == 1
				@colView = layoutClass('elasticColLeft').new( {:sideBarPxWidth=>200} );

				#construct the sidebar
				sideBarSpacer = spacerView.new( 0, 0, 0, 0 );
				sideBarSpacer.addSubView( loremIpsumView.new() );
				@colView.sidebar = sideBarSpacer;

			# Sidebar on both sides
			else
				@colView = layoutClass('elasticColBoth').new( {:leftSideBarPxWidth=>200, :rightSideBarPxWidth=>200} );

				#construct the left sidebar
				leftSideBarSpacer = spacerView.new( 0, 0, 0, 0 );
				leftSideBarSpacer.addSubView( loremIpsumView.new() );
				@colView.leftSidebar = leftSideBarSpacer;

				#construct the right sidebar
				rightSideBarSpacer = spacerView.new( 0, 0, 0, 0 );
				rightSideBarSpacer.addSubView( loremIpsumView.new() );
				@colView.rightSidebar = rightSideBarSpacer;

			end

			#construct the header
			headerSpacer1 = spacerView.new( 0, 0, 0, 0 );
			headerSpacer1.addSubView( loremIpsumView.new() );
			@colView.fullWidthHeader = headerSpacer1;

			headerSpacer2 = spacerView.new( 0, 0, 0, 0 );
			headerSpacer2.addSubView( loremIpsumView.new() );
			@colView.elasticHeader = headerSpacer2;

			#construct the main panel
			mainColSpacer = spacerView.new( 0, 0, 0, 0 );
			mainColSpacer.addSubView( loremIpsumView.new() );
			@colView.mainColumn = mainColSpacer;

			#construct the footer
			footerSpacer = spacerView.new( 0, 0, 0, 0 );
			footerSpacer.addSubView( loremIpsumView.new() );
			@colView.footer = footerSpacer;

			#Gui::HooRoundedPanelPanel.new()

			@window.contentView.addSubView( @colView );
		end

	end
end

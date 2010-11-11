module Presenters
	class SampleFixedPagePresenter < HooPresenter

		def initialize( controller, configuration )

			super( controller )

			@colView = layoutClass('fixedWidthSingleCol').new( {:sideBarPxWidth=>200} );

			#
			# All text areas top padding should be line-height - textHeight
			#

			#construct the header
			typeSize = 13;
			lineHeight = 15;
			topOffset = lineHeight - typeSize;

			# These are the views we shall be using
			spacerView 			= widgetClass('spacerView');
			loremIpsumView 		= widgetClass('loremIpsum');
			loremIpsumTitleView	= widgetClass('loremIpsumTitle');
			pullQuoteView 		= widgetClass('pullQuote1');
			infoView			= widgetClass('info1');

			headerSpacer = spacerView.new( 0, 0, 0, 0 );
			headerSpacer.addSubView( loremIpsumView.new() );
			@colView.header = headerSpacer;

			#construct the main panel
			mainColSpacer = spacerView.new( 0, 0, 0, 0 );

			subSpacer1 = spacerView.new( 0, 0, 0, 0 );
			subSpacer1.addSubView( loremIpsumView.new() );

			# margins here will collapse

			subSpacer2 = spacerView.new( 0, 0, 0, 0 );
			subSpacer2.addSubView( loremIpsumTitleView.new() );

			subSpacer3 = spacerView.new( 0, 0, 0, 0 );
			subSpacer3.addSubView( loremIpsumView.new() );


			mainColSpacer.addSubView( subSpacer1 );
			mainColSpacer.addSubView( subSpacer2 );
			mainColSpacer.addSubView( subSpacer3 );

			info1 = infoView.new()
			info1.setupDebugFixture
			mainColSpacer.addSubView( info1 );

			pullQuote = pullQuoteView.new();
			pullQuote.text = "Hello!"
			pullQuote.setupDebugFixture
			mainColSpacer.addSubView( pullQuote );

			info2 = infoView.new()
			info2.setupDebugFixture
			mainColSpacer.addSubView( info2 );

			@colView.mainColumn = mainColSpacer;

			#construct the footer
			footerSpacer = spacerView.new( 0, 0, 0, 0 );
			footerSpacer.addSubView( loremIpsumView.new() );
			@colView.footer = footerSpacer;

			#GUI::HooRoundedPanelPanel.new()

			@window.contentView.addSubView( @colView );
		end



	end
end

module Presenters
	class ElephantPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );

			@window.addheaderComponent("shit");


			bigWordView 		= widgetClass('bigWord')
			loremIpsumView 		= widgetClass('loremIpsum');

			@window.contentView.addSubView( bigWordView.new( "Trumpety trump!" ) );
			@window.contentView.addSubView( loremIpsumView.new() );

			@colView = layoutClass('fixedWidthSingleCol').new( {:sideBarPxWidth=>200} );

			@colView.header = loremIpsumView.new();
			@colView.mainColumn = loremIpsumView.new();
			@colView.footer = bigWordView.new( "I am the footers" );

			@window.contentView.addSubView( @colView );

		end


	end
end

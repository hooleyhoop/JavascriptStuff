module Presenters
	class ElephantPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			
			@window.contentView.addSubView( GUI::HooBigWordView.new( "Trumpety trump!" ) );
			@window.contentView.addSubView( GUI::HooLoremIpsumView.new() );
			
			@colView = GUI::HooFixedSingleColView.new( {:sideBarPxWidth=>200} );
			
			@colView.header = GUI::HooLoremIpsumView.new();			
			@colView.mainColumn = GUI::HooLoremIpsumView.new();
			@colView.footer = GUI::HooBigWordView.new( "I am the footers" );
			
			@window.contentView.addSubView( @colView );
			
		end

		
	end
end

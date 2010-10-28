module Presenters
	class ElephantPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			
			@window.contentView.addSubView( GUI::HooBigWordView.new( "Trumpety trump!" ) );
			@window.contentView.addSubView( GUI::HooLoremIpsumView.new() );
			
		end

		
	end
end

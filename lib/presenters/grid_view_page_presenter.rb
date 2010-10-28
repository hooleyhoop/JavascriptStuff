module Presenters
	class GridViewPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			@window.contentView.addSubView( GUI::HooGridOneView.new() );
		end

		
	end
end

module Presenters
	class GridViewPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			@window.contentView.addSubView( widgetClass('gridView').new() );
		end


	end
end

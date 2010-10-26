module Presenters
	class ColumnViewPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			@window.addSubView( GUI::HooSingleWidgetView.new() );
		end

		
	end
end

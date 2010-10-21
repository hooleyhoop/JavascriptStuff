module Presenters
	class SingleWidgetPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			@window.addSubView( GUI::HooSingleWidgetView.new() );
		end

		
	end
end

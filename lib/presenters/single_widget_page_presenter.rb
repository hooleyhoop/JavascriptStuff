module Presenters
	class SingleWidgetPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			
			widgetView = GUI::HooSingleWidgetView.new()
			widgetView.menuItems = [
				{ 'name'=>"loremIpsum", 'url'=>GUI::HooLoremIpsumView.name},
				{ 'name'=>"loremIpsumTitle", 'url'=>GUI::HooLoremIpsumTitleView.name},
				{ 'name'=>"Info One", 'url'=>GUI::HooInfoOneView.name},
				{ 'name'=>"Pull Quote", 'url'=>GUI::HooPullQuoteOneView.name},
				{ 'name'=>"List View", 'url'=>GUI::HooListOneView.name}
				
			];
			
			@window.contentView.addSubView( widgetView );
		end

		
	end
end

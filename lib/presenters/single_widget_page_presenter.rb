
module Presenters
	class SingleWidgetPagePresenter < HooPresenter

		def initialize( controller, defaultWidget='', optionalArgs={} )

			super( controller );

            @window.showGrid;

			# Conflicting ways to set default widget
			widgetView = widgetClass('singleWidget').new( defaultWidget, optionalArgs )

			allItems = GUI::HooWidgetList.widgets.keys
			allValues = GUI::HooWidgetList.widgets.values

			# If Ruby isn't phased out soon i will learn some Ruby idioms
			# Construct the menu items out of our default widget list
			allWidgetMenuItems = Array.new()
			allItems.each_with_index do |name, index|
				allWidgetMenuItems	<< { 'name'=>name, 'url'=>allValues[index] }
			end

			widgetView.menuItems = allWidgetMenuItems

			@window.contentView.addSubView( widgetView );


			#
			# TODO!
			# switch between layouts, widgets and cells
			#
			#
		end


	end
end

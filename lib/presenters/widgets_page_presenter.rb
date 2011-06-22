module Presenters
	class WidgetsPagePresenter < HooPresenter

		require "gui/views/drawing.rb"

		def initialize( controller )

			super( controller );

            @window.showGrid;

			# lets lay out all widgets
			allWidgets = Gui::HooWidgetList.widgetPaths

			allWidgets.each do |widget|
				classFromString = widget.constantize
				instance = classFromString.new()
				instance.setupDebugFixture()
				@window.contentView.addSubView( instance );
			end

			# some view can be nested
			bluView = Gui::HooWidgetList.widgetClass('blueView').new();
			bluView.setupDebugFixture();
			redView = Gui::HooWidgetList.widgetClass('redView').new();
			redView.setupDebugFixture();

			bluView.addSubView( redView );
			@window.contentView.addSubView( bluView );


		end

	end
end

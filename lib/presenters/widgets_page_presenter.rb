module Presenters
	class WidgetsPagePresenter < HooPresenter

		def initialize( controller )

			super( controller );

			# lets lay out all widgets
			allWidgets = GUI::HooWidgetList.widgetPaths

			allWidgets.each do |widget|
				classFromString = widget.constantize
				instance = classFromString.new()
				instance.setupDebugFixture()
				@window.contentView.addSubView( instance );
			end

			# some view can be nested
			bluView = GUI::HooWidgetList.widgetClass('blueView').new();
			bluView.setupDebugFixture();
			redView = GUI::HooWidgetList.widgetClass('redView').new();
			redView.setupDebugFixture();

			bluView.addSubView( redView );
			@window.contentView.addSubView( bluView );


		end

	end
end

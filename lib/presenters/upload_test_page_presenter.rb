include Gui

module Presenters
	class UploadTestPagePresenter < HooPresenter

        def initialize( controller )

			super( controller );

			colorFillClass				= widgetClass('colorFill')
			testUploadFormClass			= widgetClass('testUploadForm')

			@window.showGrid;

			colorFillView = colorFillClass.new();
			@window.contentView.addSubView( colorFillView );

			testUploadFormView = testUploadFormClass.new();
			@window.contentView.addSubView( testUploadFormView );

		end
	end
end

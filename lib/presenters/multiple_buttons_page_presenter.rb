module Presenters
	class MultipleButtonsPagePresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global

		def initialize( controller )

			super( controller );

			colorFillClass				= widgetClass('colorFill')
			testUploadFormClass			= widgetClass('testUploadForm')
			largeButtonclass			= widgetClass('largeSinglebuttonForm')

			@window.showGrid;

			colorFillView = colorFillClass.new();
			@window.contentView.addSubView( colorFillView );

			@largeButton1 = largeButtonclass.new();
			@largeButton1.action = '/pages/multiple_buttons_test_upload'

			@window.contentView.addSubView( @largeButton1 );

			@largeButton1.img = '../images/buttons/follow-button.png';
			@largeButton1.width = 105;
			@largeButton1.height = 45;
			@largeButton1.label = 'Follow'
			@largeButton1.label = 'Unfollow'
			@largeButton1.labelColor = '#fff'


		end
	end
end

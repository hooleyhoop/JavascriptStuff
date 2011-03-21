module GUI::Views::Unsorted

	# http://0.0.0.0:3000/widgets/spacedVerticalList
	class HooSpacedVerticalList < GUI::Core::HooView

		# Mock data
		def setupDebugFixture
			super();

			placeholderView1 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView2 );

			placeholderView3 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView3 );

			placeholderView4 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView4 );
    	end


	end
end

module GUI::Views::Unsorted
	class HooSpacedVerticalList < GUI::Core::HooView

		def initialize()
			super();
		end

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

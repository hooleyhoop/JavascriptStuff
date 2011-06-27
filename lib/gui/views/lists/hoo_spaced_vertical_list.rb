module Gui::Views::Lists

	# http://0.0.0.0:3000/widgets/spacedVerticalList
	class HooSpacedVerticalList < Gui::Core::HooView

		# Mock data
		def setupDebugFixture
			super();

			placeholderView1 = widgetClass('colorFill').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = widgetClass('colorFill').new()
			self.addSubView( placeholderView2 );

			placeholderView3 = widgetClass('colorFill').new()
			self.addSubView( placeholderView3 );

			placeholderView4 = widgetClass('colorFill').new()
			self.addSubView( placeholderView4 );
    	end


	end
end

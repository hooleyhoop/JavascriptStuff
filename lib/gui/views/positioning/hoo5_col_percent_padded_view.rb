module Gui::Views::Positioning

    # PLEASE FILL ME IN
    # http://0.0.0.0:3000/widgets/5col_percent_padded

	class Hoo5ColPercentPaddedView < Gui::Core::HooView

		def wasAddedToParentView
		    super();
        end

        # Mock Data
		def setupDebugFixture
			super();

			placeholderView1 = Gui::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = Gui::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView2 );

			placeholderView3 = Gui::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView3 );

			placeholderView4 = Gui::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView4 );

			placeholderView5 = Gui::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView5 );
		end

	end
end

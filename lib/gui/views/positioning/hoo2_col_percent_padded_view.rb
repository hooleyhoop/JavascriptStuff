module Gui::Views::Positioning

    # PLEASE FILL ME IN
    # http://0.0.0.0:3000/widgets/2col_percent_padded
	class Hoo2ColPercentPaddedView < Gui::Core::HooView

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
		end

	end
end

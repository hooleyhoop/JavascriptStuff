module Gui::Views::Positioning

    # PLEASE FILL ME IN
    # http://0.0.0.0:3000/widgets/4col
	class Hoo4ColView < Gui::Core::HooView

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
		end

	end
end

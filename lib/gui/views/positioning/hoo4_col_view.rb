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

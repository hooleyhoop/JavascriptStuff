module GUI::Views::Positioning

    # PLEASE FILL ME IN
	class Hoo4ColView < GUI::Core::HooView

		def initialize( args={} )
			super();
		end

		def wasAddedToParentView
		    super();
        end

        # Mock Data
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

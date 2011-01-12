module GUI::Views::Positioning

    # PLEASE FILL ME IN
    # http://0.0.0.0:3000/widgets/5col

	class Hoo5ColPercentPaddedView < GUI::Core::HooView

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

			placeholderView5 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView5 );
		end

	end
end

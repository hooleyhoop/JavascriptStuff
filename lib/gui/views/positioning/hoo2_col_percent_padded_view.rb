module GUI::Views::Positioning

    # PLEASE FILL ME IN
    # http://0.0.0.0:3000/widgets/2col_percent_padded
	class Hoo2ColPercentPaddedView < GUI::Core::HooView

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
		end

	end
end

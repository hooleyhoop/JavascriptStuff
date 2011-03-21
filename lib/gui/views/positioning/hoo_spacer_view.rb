module GUI::Views::Positioning
	class HooSpacerView < GUI::Core::HooView

		attr_accessor :top, :right, :bottom, :left

		def initialize( top=0, right=0, bottom=0, left=0 )
			super();
			@top = top
			@right = right
			@bottom = bottom
			@left = left
		end

		# Mock Data
		def setupDebugFixture
			super();

			placeHolderView = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeHolderView );

			@top = @right = @bottom = @left = 15
		end

	end
end

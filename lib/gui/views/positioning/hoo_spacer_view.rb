module Gui::Views::Positioning

	# http://0.0.0.0:3000/widgets/spacerView
	class HooSpacerView < Gui::Core::HooView

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

			placeHolderView = widgetClass('colorFill').new()
			self.addSubView( placeHolderView );

			@top = @right = @bottom = @left = 15
		end

	end
end

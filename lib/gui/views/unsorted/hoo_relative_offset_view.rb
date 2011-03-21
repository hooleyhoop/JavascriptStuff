module GUI::Views
	class HooRelativeOffsetView < GUI::Core::HooView

		attr_accessor :top, :right, :bottom, :left

		def initialize( top=0, right=0, bottom=0, left=0 )
			super();
			@top = top
			@right = right
			@bottom = bottom
			@left = left
		end

	end
end

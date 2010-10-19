module GUI
	class HooSpacerView < HooView

		attr_accessor :top, :right, :bottom, :left

		def initialize( top, right, bottom, left )
			super();
			@top = top
			@right = right
			@bottom = bottom
			@left = left
		end

	end
end

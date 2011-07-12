module Gui::Views::Positioning

	# http://0.0.0.0:3000/widgets/HooFixedSizeView
	class HooFixedSizeView < Gui::Core::HooView

		attr_accessor :width, :height

		def initialize( args )
			super( args )
			extractArgs( args, {:width=>100, :height=>100} );
		end

		# Mock Data
		def setupDebugFixture
			super
			placeHolderView = widgetClass('HooColorFill').new()
			self.addSubView( placeHolderView );
		end

		def widthString()
			if @width.kind_of? Integer
				return "#{@width}px"
			end
			return @width
		end

		def heightString()
			if @height.kind_of? Integer
				return "#{@height}px"
			end
			return @height
		end
	end
end

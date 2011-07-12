module Gui::Views::Positioning

	# http://0.0.0.0:3000/widgets/HooSpacerView
	class HooSpacerView < Gui::Core::HooView

		attr_accessor :top, :right, :bottom, :left

		def initialize( args={} )
			super
			extractArgs( args, {:top=>0, :right=>0, :bottom=>0, :left=>0} );
		end

		# Mock Data
		def setupDebugFixture
			super();

			placeHolderView = widgetClass('HooColorFill').new()
			self.addSubView( placeHolderView );

			@top = @right = @bottom = @left = 15
		end

	end
end

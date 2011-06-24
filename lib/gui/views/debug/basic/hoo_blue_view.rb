module Gui::Views::Debug::Basic

	# http://0.0.0.0:3000/widgets/blueView
	class HooBlueView < Gui::Core::HooView

		attr_accessor :width, :height;

		def self.dslName() 'blueView' end

		def initialize( args={} )
			super(args);
			@width = 90;
			@height = 90;
		end

	end
end

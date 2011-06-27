module Gui::Views::Debug::Basic

	# http://0.0.0.0:3000/widgets/HooRedView
	class HooRedView < Gui::Core::HooView

		attr_accessor :width, :height;

		def initialize( args={} )
			super(args={});
			@width = 75;
			@height = 75;
		end

	end
end

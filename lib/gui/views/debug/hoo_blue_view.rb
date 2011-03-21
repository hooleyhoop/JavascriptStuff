module GUI::Views::Debug

	# http://0.0.0.0:3000/widgets/blueView
	class HooBlueView < GUI::Core::HooView

		def initialize( args={} )
			super(args);
			@width = 90;
			@height = 90;
		end

	end
end

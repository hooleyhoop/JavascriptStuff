module GUI::Views::Debug

	# http://0.0.0.0:3000/widgets/redView
	class HooRedView < GUI::Core::HooView

		def initialize( args={} )
			super(args={});
			@width = 75;
			@height = 75;
		end

	end
end
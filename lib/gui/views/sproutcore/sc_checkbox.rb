module GUI::Views::Sproutcore

	# http://0.0.0.0:3000/widgets/sc_checkbox
	class ScCheckbox < GUI::Core::HooView

		attr_accessor :width, :height;

		def initialize( args={} )
			super(args={});
			@width = 75;
			@height = 75;
		end

	end
end

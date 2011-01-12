module GUI::Views::Drawing

    # Button img must have 2 states. :Height is just the height of one state

	# http://0.0.0.0:3000/widgets/largeSinglebuttonForm
	class HooLargeSingleButtonForm < GUI::Core::HooView

		attr_accessor :img;
		attr_accessor :width, :height;
		attr_accessor :label, :labelColor;

		def initialize( args={} )
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/buttons/edit-button.png';
			@width = 105;
			@height = 45;
			@label = 'hello'
			@labelColor = '#969696'
		end

	end
end

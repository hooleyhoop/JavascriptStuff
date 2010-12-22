module GUI::Views::Audioboo

    # Button img must have 2 states. :Height is just the height of one state
	class FollowButtonSection < GUI::Core::HooView

        attr_accessor :img;
        attr_accessor :width, :height;
        attr_accessor :label

		def initialize
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/buttons/follow-button.png';
			@width = 105;
			@height = 45;
			@label = 'Follow'
		end

	end
end

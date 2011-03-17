module GUI::Views::Audioboo

	class AddComment < GUI::Core::HooView

        attr_accessor :img, :postButtonImg;
        attr_accessor :width, :height;

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/user/sample_user1.png';
			@postButtonImg = '../images/buttons/post-button.png';
			@width = 90;
			@height = 90;
		end

	end
end

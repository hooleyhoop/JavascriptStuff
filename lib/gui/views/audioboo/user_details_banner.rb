module GUI::Views::Audioboo

	class UserDetailsBanner < GUI::Core::HooView

        attr_accessor :img;
        attr_accessor :width, :height;
        attr_accessor :userName;

		def initialize
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/user/my_pic.png';
			@width = 75;
			@height = 75;
			@userName = 'stevehooley';
		end

	end
end

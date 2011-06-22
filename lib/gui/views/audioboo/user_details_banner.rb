module Gui::Views::Audioboo

    # http://0.0.0.0:3000/widgets/userDetailsBanner
	class UserDetailsBanner < Gui::Core::HooView

        attr_accessor :img;
        attr_accessor :imgSize;
        attr_accessor :userName;
		attr_accessor :userHomePageURL;
		attr_accessor :stats;

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/user/sample_user2.png';
			@imgSize = [75,75];
			@userName = 'stevehooley';
			@userHomePageURL = 'http://apple.com'
			@stats = {	boos: { total:190, url: 'http://apple.com'},
						favourites: { total:3, url: 'http://virgin.com'},
						followers: { total:347, url: 'http://facebook.com'}
						};

		end

	end
end

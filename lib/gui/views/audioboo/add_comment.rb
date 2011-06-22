module Gui::Views::Audioboo

	# http://0.0.0.0:3000/widgets/addComment
	class AddComment < Gui::Core::HooView

        attr_accessor :img, :postButtonImg;
        attr_accessor :width, :height;

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

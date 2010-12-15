module GUI::Views
	class HooSlidingDoorsPanel < GUI::Core::HooView

    	attr_accessor :cornerDim;
    	attr_accessor :imgPath;

		def initialize
			super();
			self.cornerDim = 15;
			@imgPath =  '../images/mainpanel/main_panel';
		end

        def top
            @imgPath + '_top.png'
        end

        def right
            @imgPath + '_right.png'
        end

        def bottom
            @imgPath + '_bottom.png'
        end

        def left
            @imgPath + '_left.png'
        end

        def corners
            @imgPath + '_corners.png'
        end

        def fill
            @imgPath + '_fill.png'
        end
	end
end

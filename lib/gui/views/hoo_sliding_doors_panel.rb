module GUI::Views

    # Welcomen! There are 2 types at the moment. Outer and Inner

	class HooSlidingDoorsPanel < GUI::Core::HooView

    	attr_accessor :cornerDim;
    	attr_accessor :imgPath;

		def initialize
			super();
			self.cornerDim = 15;
			@speechPosition = '';
		end

        def top
            @imgPath + '_top2.png'
        end

        def right
            @imgPath + '_right2.png'
        end

        def bottom
            @imgPath + '_bottom2.png'
        end

        def left
            @imgPath + '_left2.png'
        end

        def corners
            @imgPath + '_corners2.png'
        end

        def fill
            @imgPath + '_fill2.png'
        end

        def style=( styleName )
            if( styleName=='inner' )
                @imgPath = '../images/innerpanel/inner_panel';
            else
    			@imgPath =  '../images/mainpanel/main_panel';
    		end
        end

		# Mock data
		def setupDebugFixture
			super();

   			self.style = 'main'

            # Add some content so it's easier to see what is going on
            loremIpsumView = GUI::HooWidgetList.widgetClass('loremIpsum');
            loremIpsumView1 = loremIpsumView.new();
    	    addSubView( loremIpsumView1 );

		end

	end
end

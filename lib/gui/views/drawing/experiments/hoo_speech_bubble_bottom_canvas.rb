module Gui::Views::Drawing::Experiments

    # http://0.0.0.0:3000/widgets/HooSpeechBubbleBottomCanvas

	class HooSpeechBubbleBottomCanvas < Gui::Core::HooView

        attr_accessor :fixedRowHeight;
    	attr_accessor :cornerDim;
    	attr_accessor :imgPath;
    	attr_accessor :triangleImgpath;
    	attr_accessor :triangleImgSize;

		def initialize( args={} )
			super(args);
			self.cornerDim = 15;
			@speechPosition = '';
		end

        def constructSubViews

			@fixedRowHeight = 15;
            @imgPath = '../images/innerpanel/inner_panel';
			@triangleImgpath = '../images/innerpanel/inner_panel_speech_bottom.png';
			@triangleImgSize = [30,15];

			#slidingDoorsPanel   = widgetClass('slidingDoorsPanel1');
            #backgroundImage     = widgetClass('backgroundImage');
            #relativeOffsetView  = widgetClass('relativeOffsetView');


			# manually tweak the position
			#offsetView = relativeOffsetView.new( 0,0,0, 30 );

			#offsetView.addSubView( triangleImg );
			#dividerView.addSubView( offsetView );


        end

        # from outside you cannot directly add children to this, they go straight to the inner panel
		#def addSubView( aView )
		#    @innerPanel1.addSubView( aView );
        #end

		# Mock data
		def setupDebugFixture

			super();

			self.constructSubViews()

            # Add some content so it's easier to see what is going on
            loremIpsumView = widgetClass('HooLoremIpsumView');
            loremIpsumView1 = loremIpsumView.new();
    	    addSubView( loremIpsumView1 );

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

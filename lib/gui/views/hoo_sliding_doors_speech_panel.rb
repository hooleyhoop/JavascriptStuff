module GUI::Views

    # http://0.0.0.0:3000/widgets/speechBubblePane

    # The speech panel is actual an hoo_sliding_doors_panel inner panel with a little speech tag appended.
    # The speech tag can be on the bottom or on the right or on the left
	class HooSlidingDoorsSpeechPanel < GUI::Core::HooView

        attr_accessor :speechPosition;

		def initialize( args={} )
			super();
		end

        def constructSubViews

			slidingDoorsPanel   = GUI::HooWidgetList.widgetClass('slidingDoorsPanel1');
			blueView            = GUI::HooWidgetList.widgetClass('blueView');
            backgroundImage     = GUI::HooWidgetList.widgetClass('backgroundImage');
            relativeOffsetView  = GUI::HooWidgetList.widgetClass('relativeOffsetView');

            # 2 different setups, speech thing on the right or speech thing on the bottom
            if( @speechPosition=='right' )
                splitView1 = GUI::HooWidgetList.widgetClass('verticalSplitView');
                dividerView = splitView1.new();
                dividerView.setFixedColumn( 'right', 15 );

                # careful here, we overide addSubview so call the secret method
                self._addSubView( dividerView );

                # TODO: This is for the speech thing on the right, lets also do the speech thingy on the bottom
                @innerPanel1 = slidingDoorsPanel.new();
                @innerPanel1.style = 'inner'
                dividerView.addSubView( @innerPanel1 );

                # manually tweak the position
                offsetView = relativeOffsetView.new( 30,0,0,-2 );

                placeholder = backgroundImage.new();
                placeholder.img = '../images/innerpanel/inner_panel_speech_right.png';
                placeholder.width = 15;
                placeholder.height = 30;

                offsetView.addSubView( placeholder );
                dividerView.addSubView( offsetView );

            elsif( @speechPosition=='left' )
                splitView1 = GUI::HooWidgetList.widgetClass('verticalSplitView');
                dividerView = splitView1.new();
                dividerView.setFixedColumn( 'left', 15 );
                # careful here, we overide addSubview so call the secret method
                self._addSubView( dividerView );

                # manually tweak the position of the triangle
                offsetView = relativeOffsetView.new( 15,0,0,1 );

                triangleImg = backgroundImage.new();
                triangleImg.img = '../images/inner_white_panel/inner_panel_speech_left.png';
                triangleImg.width = 15;
                triangleImg.height = 30;

                offsetView.addSubView( triangleImg );
                dividerView.addSubView( offsetView );

                 # TODO: This is for the speech thing on the right, lets also do the speech thingy on the bottom
                @innerPanel1 = slidingDoorsPanel.new();
                @innerPanel1.style = 'inner_white'
                dividerView.addSubView( @innerPanel1 );

            elsif( @speechPosition=='bottom' )
			    splitView2 = GUI::HooWidgetList.widgetClass('horizontalSplitView');
                dividerView = splitView2.new();
                dividerView.setFixedColumn( 'bottom', 15 );
                self._addSubView( dividerView );

                @innerPanel1 = slidingDoorsPanel.new();
                @innerPanel1.style = 'inner'
                dividerView.addSubView( @innerPanel1 );

                # manually tweak the position
                offsetView = relativeOffsetView.new( 0,0,0, 30 );

                triangleImg = backgroundImage.new();
                triangleImg.img = '../images/innerpanel/inner_panel_speech_bottom.png';
                triangleImg.width = 30;
                triangleImg.height = 15;
				triangleImg.customCSSAttributes = { opacity:0.8 };

                offsetView.addSubView( triangleImg );
                dividerView.addSubView( offsetView );
            end


        end

        # from outside you cannot directly add children to this, they go straight to the inner panel
		def addSubView( aView )
		    @innerPanel1.addSubView( aView );
        end

		# Mock data
		def setupDebugFixture

			super();

			@speechPosition = 'right';
			self.constructSubViews()

            # Add some content so it's easier to see what is going on
            loremIpsumView = GUI::HooWidgetList.widgetClass('loremIpsum');
            loremIpsumView1 = loremIpsumView.new();
    	    addSubView( loremIpsumView1 );

		end


	end
end

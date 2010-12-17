module GUI::Views

    # The speech panel is actual an hoo_sliding_doors_panel inner panel with a little speech tag appended.
    # The speech tag can be on the bottom or on the right or on the left
	class HooSlidingDoorsSpeechPanel < GUI::Core::HooView

        attr_accessor :speechPosition;

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
                offsetView = relativeOffsetView.new( 30,0,0,-1 );

                placeholder = backgroundImage.new();
                placeholder.img = '../images/innerpanel/inner_panel_speech_right.png';
                placeholder.width = 15;
                placeholder.height = 30;

                offsetView.addSubView( placeholder );
                dividerView.addSubView( offsetView );

            else
			    splitView2 = GUI::HooWidgetList.widgetClass('horizontalSplitView');
                dividerView = splitView2.new();
                dividerView.setFixedColumn( 'bottom', 15 );
                self._addSubView( dividerView );

                @innerPanel1 = slidingDoorsPanel.new();
                @innerPanel1.style = 'inner'
                dividerView.addSubView( @innerPanel1 );

                # manually tweak the position
                offsetView = relativeOffsetView.new( -1,0,0,30 );

                placeholder = backgroundImage.new();
                placeholder.img = '../images/innerpanel/inner_panel_speech_bottom.png';
                placeholder.width = 30;
                placeholder.height = 15;

                offsetView.addSubView( placeholder );
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
			self.constructSubViews()

            # Add some content so it's easier to see what is going on
            loremIpsumView = GUI::HooWidgetList.widgetClass('loremIpsum');
            loremIpsumView1 = loremIpsumView.new();
    	    addSubView( loremIpsumView1 );

		end


	end
end

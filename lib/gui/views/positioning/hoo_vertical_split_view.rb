module GUI::Views::Positioning

    # First of all lets split left right

	# http://0.0.0.0:3000/widgets/verticalSplitView
	class HooVerticalSplitView < GUI::Core::HooView

        attr_accessor :fixedColSide;

        # specify one or the other
        attr_accessor :fixedColWidth;
        attr_accessor :fixedColPercent;

		def initialize( args={} )
			super(args)
			@fixedColSide = ''
			@fixedColPercent=0;
		end

# --------------------------- use one or the other ---------------------------------
        # left / right
        def setFixedColumn( fixedColName, fixedColWidth );
            @fixedColWidth = fixedColWidth;
            @fixedColSide = fixedColName;
        end

        # left / right, 33
        def setPercentage( col, percent )
            @fixedColSide = col;
            @fixedColPercent = percent;
        end
# ---------------------------------------------------------------------------------

		def wasAddedToParentView
		    super();
		    if( @fixedColSide=='' )
		        raise "Bullshit! you need to set which side the column goes on"
		    end
        end

        # Mock Data
		def setupDebugFixture
			super();
            setFixedColumn('left', 60 )

			placeholderView1 = GUI::HooWidgetList.widgetClass('loremIpsum').new()
			self.addSubView( placeholderView1 );

			placeHolderView2 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeHolderView2 );
		end

	end
end

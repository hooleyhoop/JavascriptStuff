module GUI::Views

    # PLEASE FILL ME IN
	class HooTwoElasticColsFixedGutter < GUI::Core::HooView


        # specify one or the other
        attr_accessor :fixedColWidth;
        attr_accessor :fixedColPercent;

		def initialize
			super();
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
		#    if( @fixedColSide=='' )
		#        raise "Bullshit! you need to set which side the column goes on"
		#    end
        end

        # Mock Data
		def setupDebugFixture
			super();
            setFixedColumn('right', 45 )

			placeholderView1 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = GUI::HooWidgetList.widgetClass('colorFill').new()
			self.addSubView( placeholderView2 );
		end

	end
end

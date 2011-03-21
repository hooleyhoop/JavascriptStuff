module GUI::Views

    # First of all lets split top / bottom
	class HooHorizontalSplitView < GUI::Core::HooView

        attr_accessor :fixedColWidth;
        attr_accessor :fixedColSide;

		def initialize
			super();
		end

        # top / bottom
        def setFixedColumn( fixedColName, fixedColWidth );
            @fixedColWidth = fixedColWidth;
            @fixedColSide = fixedColName;
        end

		def wasAddedToParentView
		    super();
		    if( @fixedColSide=='' )
		        raise "Bullshit! you need to wet which side the column goes on"
		    end
        end

        # Mock Data
		def setupDebugFixture
			super();
            setFixedColumn('top', 100 )

			placeholderView1 = GUI::HooWidgetList.widgetClass('loremIpsum').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = GUI::HooWidgetList.widgetClass('loremIpsum').new()
			self.addSubView( placeholderView2 );
		end

	end
end

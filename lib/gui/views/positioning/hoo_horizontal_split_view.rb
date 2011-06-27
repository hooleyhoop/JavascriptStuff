module Gui::Views::Positioning

    # First of all lets split top / bottom
	# http://0.0.0.0:3000/widgets/horizontalSplitView
	class HooHorizontalSplitView < Gui::Core::HooView

        attr_accessor :fixedColWidth;
        attr_accessor :fixedColSide;

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

			placeholderView1 = widgetClass('loremIpsum').new()
			self.addSubView( placeholderView1 );

			placeholderView2 = widgetClass('loremIpsum').new()
			self.addSubView( placeholderView2 );
		end

	end
end

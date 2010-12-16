module GUI::Views

    # First of all lets split left right
	class HooVerticalSplitView < GUI::Core::HooView

        attr_accessor :fixedColWidth;
        attr_accessor :fixedColSide;

		def initialize
			super();
			@fixedColSide = ''
		end

        # left / right
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

	end
end

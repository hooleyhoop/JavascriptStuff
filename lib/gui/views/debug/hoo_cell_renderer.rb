module Gui::Views::Debug

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=hoo_user_comment_cell

    # Useful for debugging cells
	class HooCellRenderer < Gui::Core::HooView

		attr_accessor :cell, :cellName;
    	attr_accessor :dataSrc;

        # will create it's own cell but you need to set the cell-name
		def initialize( args={} )
			super(args);
			extractArgs( args, {:cellName=>'horizontalList1'} );
		end

		def wasAddedToParentView
		    super();
            self.cell = Gui::HooWidgetList.cellClass( @cellName ).new();

            # Cellrenderer just displays the chosen cell's debug fixture
            self.dataSrc = cell
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

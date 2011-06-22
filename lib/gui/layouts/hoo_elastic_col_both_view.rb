module Gui::Layouts
	class HooElasticColBothView < Gui::Core::HooView

		attr_accessor :fullWidthHeader, :elasticHeader, :footer, :mainColumn, :leftSidebar, :rightSidebar;
		attr_accessor :leftColWidth, :rightColWidth;
		attr_accessor :debugBorder, :debugCol1, :debugCol2, :debugCol3, :debugCol4;

		def initialize( hashArg )
			super(hashArg);
			@leftColWidth = hashArg[:leftSideBarPxWidth];
			@rightColWidth = hashArg[:rightSideBarPxWidth];

			if(false)
				@debugBorder = "border:1px solid black;";
				@debugCol1 = "background-color:#ff0000;";
				@debugCol2 = "background-color:#fff000;";
				@debugCol3 = "background-color:#00ff00;";
				@debugCol4 = "background-color:#ff00ff;";
			end
		end

	end
end

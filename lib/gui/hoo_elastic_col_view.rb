module GUI
	class HooElasticColView < HooView

		attr_accessor :header, :footer, :mainColumn, :sidebar;
		attr_accessor :sideBarWidth;
		attr_accessor :debugBorder, :debugCol1, :debugCol2, :debugCol3, :debugCol4;
		
		def initialize( hashArg )
			super();
			@sideBarWidth = hashArg[:sideBarEmWidth];
			
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

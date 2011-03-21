module GUI::Views::Unsorted
	class HooSpacedCellList < GUI::Core::HooView

		attr_accessor :cell;
    	attr_accessor :dataSrc;

		def initialize()
			super();
		end

		# Mock data
		def setupDebugFixture
			super();
      # cell
			@cell = GUI::HooWidgetList.cellClass('list1').new()
			@cell.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email"
			}
			@dataSrc = self;
    	end

		# Mock Data Provider
		def allItems
			return [
				{ 'name'=>"jimmy hands",          'email'=> "sss@gmail.com" },
				{ 'name'=>"Taylor Woodrow",       'email'=> "asd@hotmail.com" },
				{ 'name'=>"Shanti",               'email'=> "ggh@yahoo.com" },
				{ 'name'=>"The Shadow",           'email'=> "wegbdfbf@tennis.com" },
				{ 'name'=>"Janet Jackson",        'email'=> "7hghe4fsads@bbc.com" }
			];
		end

        def mapping=( celMapping )
            @cell.mapping = celMapping;
        end

	end
end

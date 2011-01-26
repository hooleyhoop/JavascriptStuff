module GUI::Views

	# http://0.0.0.0:3000/widgets/cuteDropDownMenu
	class HooCuteDropDownMenu < GUI::Core::HooView

		attr_accessor :content;
		attr_accessor :cell;

		def initialize( args={} )
			super();
		end

		# Mock data
		def setupDebugFixture
			super();

		# add the header

		# content
			@content = [
				{ 'name'=>"jimmy hands",          'email'=> "sss@gmail.com" },
				{ 'name'=>"Taylor Woodrow",       'email'=> "asd@hotmail.com" },
				{ 'name'=>"Shanti",               'email'=> "ggh@yahoo.com" },
				{ 'name'=>"The Shadow",           'email'=> "wegbdfbf@tennis.com" },
				{ 'name'=>"Janet Jackson",        'email'=> "7hghe4fsads@bbc.com" }
				];

		# cell
			@cell = GUI::HooWidgetList.cellClass('horizontalList1').new()
			@cell.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email"
			}
		end

	end
end

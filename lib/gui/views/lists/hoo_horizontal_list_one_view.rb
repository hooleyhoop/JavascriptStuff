module Gui::Views::Lists

    # http://0.0.0.0:3000/widgets/horizontalList1
	class HooHorizontalListOneView < Gui::Core::HooView

		attr_accessor :content;
		attr_accessor :cell;

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
			@cell = Gui::HooWidgetList.cellClass('horizontalList1').new()
			@cell.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email"
			}
		end

	end
end

module Gui::Views::Lists

	# http://0.0.0.0:3000/widgets/list1
	class HooListOneView < Gui::Core::HooView

		attr_accessor :content;
		attr_accessor :cell;
		attr_accessor :headerView;

		# Mock data
		def setupDebugFixture
			super();

      # add the header
			@headerView = Gui::HooWidgetList.widgetClass('loremIpsum').new()

      # content
			@content = [
				{ 'name'=>"jimmy hands",          'email'=> "sss@gmail.com" },
				{ 'name'=>"Taylor Woodrow",       'email'=> "asd@hotmail.com" },
				{ 'name'=>"Shanti",               'email'=> "ggh@yahoo.com" },
				{ 'name'=>"The Shadow",           'email'=> "wegbdfbf@tennis.com" },
				{ 'name'=>"Janet Jackson",        'email'=> "7hghe4fsads@bbc.com" }
			];

      # cell
			@cell = Gui::HooWidgetList.cellClass('list1').new()
			@cell.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email"
			}
    	end


	end
end

module GUI::Views::Unsorted

    # http://0.0.0.0:3000/widgets/dropdownMenuView
	class HooDropdownMenuView < GUI::Core::HooView

    attr_accessor :menuTitle, :menuItems;

		def initialize( args={} )
			super(args);

			@menuTitle = "Select a widget";
			@menuItems = [	{ 'name'=>"item one", 'url'=>"/pages/_ajaxHTML"},
							{ 'name'=>"item two", 'url'=>"/pages/_ajaxHTML"},
							{ 'name'=>"item three", 'url'=>"/pages/_ajaxHTML"},
							{ 'name'=>"item four", 'url'=>"/pages/_ajaxHTML"},
							{ 'name'=>"item five", 'url'=>"/pages/_ajaxHTML"}
						]
		end

	end
end

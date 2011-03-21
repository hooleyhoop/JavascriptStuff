module GUI::Views
	class HooDropdownMenuView < GUI::Core::HooView

    attr_accessor :menuTitle, :menuItems;

		def initialize
			super();

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

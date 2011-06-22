module Gui::Views::Drawing::Menus::Items

	# REMEMBER! THEY BOTH USE THE SAME partial

	# http://0.0.0.0:3000/widgets/textToggleItem?initialState=1
	class HooTextToggleItem < Gui::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth

		include HooTextMenuItemMixin

		attr_accessor :position;

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'left'
		end

		# we share a partial with HooTextLinkItem
		def self.partial_path
			return HooTextLinkItem.name.underscore;
		end

	end
end

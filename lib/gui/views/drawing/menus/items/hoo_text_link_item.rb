module GUI::Views::Drawing::Menus::Items

	# REMEMBER! THEY BOTH USE THE SAME partial

	# http://0.0.0.0:3000/widgets/textLinkItem?initialState=1
	class HooTextLinkItem < GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimpleDynamicWidth

		include WidgetsHelper

		# This is the mixin
		include HooTextMenuItemMixin


		attr_accessor :position;

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'middle'
		end

	end
end

module GUI::Views::Drawing::Menus::Items

	# http://0.0.0.0:3000/widgets/textLinkItem?initialState=1
	class HooTextLinkItem < GUI::Views::Drawing::Buttons::DivButton::HooDivButtonSimpleDynamicWidth

		attr_accessor :position;

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'middle'
		end

	end
end

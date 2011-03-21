module GUI::Views::Drawing::Menus::Items

	# REMEMBER! THEY BOTH USE THE SAME partial

	# http://0.0.0.0:3000/widgets/textLinkItem?initialState=1
	class HooTextLinkItem < HooTextItemAbstract

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'middle'
		end

	end
end

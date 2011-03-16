module GUI::Views::Drawing::Menus::Items

	# http://0.0.0.0:3000/widgets/textLinkItem
	class HooTextLinkItem < GUI::Views::Drawing::Buttons::HooDivButtonSimpleDynamicWidth

		include Test::Unit::Assertions
		attr_accessor :position;

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'middle'
		end

	end
end

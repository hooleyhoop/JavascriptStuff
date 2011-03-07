module GUI::Views::Drawing::Menus::Items

	# http://0.0.0.0:3000/widgets/textLinkItem
	class HooTextLinkItem < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :text;
		attr_accessor :url;

		def initialize( args={} )
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@text = 'click me!'
			@url = 'http://apple.com'
		end

	end
end

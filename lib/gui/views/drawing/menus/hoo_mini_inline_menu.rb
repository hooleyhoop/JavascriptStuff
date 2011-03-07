module GUI::Views::Drawing::Menus

	# http://0.0.0.0:3000/widgets/miniInLineMenu
	class HooMiniInlineMenu < GUI::Core::HooView

		include Test::Unit::Assertions

		def initialize( args={} )
			super();
		end

		def addToggleItem
		end

		def addLinkItem
		end

        # Mock Data
		def setupDebugFixture
			super();

			item1 = GUI::HooWidgetList.widgetClass('textToggleItem');
			item2 =	GUI::HooWidgetList.widgetClass('textLinkItem');
			item3 = GUI::HooWidgetList.widgetClass('textLinkItem');

			this.addToggleItem( item1 );
			this.addLinkItem( item2 );
			this.addLinkItem( item3 );
		end



	end
end

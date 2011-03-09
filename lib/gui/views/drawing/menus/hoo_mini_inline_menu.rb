module GUI::Views::Drawing::Menus

	# http://0.0.0.0:3000/widgets/miniInLineMenu
	class HooMiniInlineMenu < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :img;

		def initialize( args={} )
			@img = '../images/menu/mini_menu.png';
			super();
		end

		def addToggleItem( item )
			self.addSubView( item );
		end

		def addLinkItem( item )
			self.addSubView( item );
		end

        # Mock Data
		def setupDebugFixture
			super();

			item1 = GUI::HooWidgetList.widgetClass('textToggleItem').new();
			item1.initialState=1;
			item1.labelStates = ['Disabled', 'Follow', 'Down1', 'Unfollow', 'Down2'];
			item1.action = '/widgets/_ajaxPostTest';

			item2 =	GUI::HooWidgetList.widgetClass('textLinkItem').new();
			item2.text = 'click me!'
			item2.url = 'http://apple.com'

			item3 = GUI::HooWidgetList.widgetClass('textLinkItem').new();
			item3.text = 'click me!'
			item3.url = 'http://apple.com'

			self.addToggleItem( item1 );
			self.addLinkItem( item2 );
			self.addLinkItem( item3 );
		end



	end
end

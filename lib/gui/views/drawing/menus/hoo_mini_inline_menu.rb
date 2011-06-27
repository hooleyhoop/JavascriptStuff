module Gui::Views::Drawing::Menus

	# http://0.0.0.0:3000/widgets/miniInLineMenu
	class HooMiniInlineMenu < Gui::Core::HooView

		include Test::Unit::Assertions

		attr_accessor	:height
		attr_accessor 	:img
		attr_accessor	:labelColor

		def initialize( args={} )
			@img = '../images/buttons/simple-button-dynamic-width/3-state-combine-small.png';
			super(args);
		end

		def addToggleItem( item )
			item.size = [-1,@height];
			item.img = @img;
			item.labelColor = @labelColor;
			item.cornerRad = 5
			self.addSubView( item );
		end

		def addLinkItem( item )
			item.size = [-1,@height];
			item.img = @img;
			item.labelColor = @labelColor;
			item.cornerRad = 5
			self.addSubView( item );
		end

        # Mock Data
		def setupDebugFixture
			super();

			@height = 15; # Border will nesarily be applied ontop of this
			@labelColor = '#3171d7';

			item1 = widgetClass('textToggleItem').new( :initialState=>1, :cornerRad=>10, :border=>0 );
			item1.labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			item1.action = '/widgets/_ajaxPostTest';
			item1.position = 'left';

			itemMid = widgetClass('textLinkItem').new( :initialState=>1, :cornerRad=>10, :border=>0 );
			itemMid.labelStates = ['off', 'coffee maplin', 'down'];
			itemMid.action = '/widgets/_ajaxPostTest';
			itemMid.position = 'middle';

			item2 = widgetClass('textLinkItem').new( :initialState=>0, :cornerRad=>10, :border=>0 );
			item2.labelStates = ['coffee maplin', 'coffee maplin', 'coffee maplin'];
			item2.action = '/widgets/_ajaxPostTest';
			item2.position = 'right';

			#item2 =	widgetClass('textLinkItem').new();
			#item2.text = 'click me!'
			#item2.url = 'http://apple.com'

			#item3 = widgetClass('textLinkItem').new();
			#item3.text = 'click me!'
			#item3.url = 'http://apple.com'

			self.addToggleItem( item1 );
			self.addLinkItem( itemMid );
			self.addLinkItem( item2 );
			#self.addLinkItem( item3 );

			#item4 = widgetClass('formButtonToggle').new( :initialState=>1 );
			#item4.img = '../images/menu/mini_menu.png';
			#item4.size = [105,23];
			#item4.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
			#item4.labelColor = '#ff'
			#item4.action = '/widgets/_ajaxPostTest'

			#self.addToggleItem( item4 );

			#item5 = widgetClass('formButtonToggle').new( :initialState=>1 );
			#item5.img = '../images/menu/mini_menu.png';
			#item5.size = [105,23];
			#item5.labelStates = ['-Off-', 'Do It', 'Do It-D', 'UnDoIt', 'UnDoIt-D'];
			#item5.labelColor = '#ff'
			#item5.action = '/widgets/_ajaxPostTest'

			#self.addToggleItem( item5 );

		end


	end
end

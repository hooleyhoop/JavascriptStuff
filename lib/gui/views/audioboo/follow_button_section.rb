module Gui::Views::Audioboo

	# YES, the follow button section is small, but i dont think it should be on this page at all,  so this is a consession

    # http://0.0.0.0:3000/widgets/followButtonSection
	class FollowButtonSection < Gui::Core::HooView

		#attr_accessor	:largeButton;
		attr_accessor	:inLineMenu;

		def initialize( args={} )
			super(args);

			#
			# TODO: The follow button must be optional
			#

			#
			# TODO: want a toggle button
			#

			#
			# TODO: IF button can be different heights, how do i customize the css
			#

			#
			# TODO: How can i have an ajax button that falls back to form
			#

			isFollowing = true;
			followButtonState = isFollowing ? 3 : 1;

			@inLineMenu = widgetClass('miniInLineMenu').new();
			@inLineMenu.height = 15;
			@inLineMenu.labelColor = '#3574d7';

			item1 = widgetClass('textToggleItem').new(  :initialState=>1 );
			item1.labelStates = ['follow', 'follow', 'follow', 'un-follow', 'un-follow'];
			item1.action = '/widgets/_ajaxPostTest';
			item1.position = 'left';

			itemMid = widgetClass('textLinkItem').new(  :initialState=>1 );
			itemMid.labelStates = ['rss', 'rss', 'rss'];
			itemMid.action = '/widgets/_ajaxPostTest';
			itemMid.position = 'middle';

			item2 = widgetClass('textLinkItem').new( :initialState=>1 );
			item2.labelStates = ['iTunes', 'iTunes', 'iTunes'];
			item2.action = '/widgets/_ajaxPostTest';
			item2.position = 'right';

			@inLineMenu.addToggleItem( item1 );
			@inLineMenu.addLinkItem( itemMid );
			@inLineMenu.addLinkItem( item2 );

			# OLD WAY
			#largeButtonclass = widgetClass('formButtonToggle')
			#@largeButton = largeButtonclass.new( :state=>followButtonState );
			#@largeButton.img = '../images/buttons/follow_button/follow-button.png';
			#@largeButton.size = [105,45];
			#@largeButton.labelStates = ['Follow', 'Follow', '', 'Unfollow', ''];
			#@largeButton.labelColor = '#fff';
			#@largeButton.action = '/widgets/_ajaxPostTest';

			#largeButtonclass =  widgetClass('largeSinglebuttonForm')
			#@largeButton = largeButtonclass.new();
			#@largeButton.img = '../images/buttons/follow_button/follow-button.png';
			#@largeButton.width = 105;
			#@largeButton.height = 45;
			#@largeButton.label = 'Follow'
			#@largeButton.label = 'Unfollow'
			#@largeButton.labelColor = '#fff'

		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

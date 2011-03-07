module GUI::Views::Audioboo

    # http://0.0.0.0:3000/widgets/followButtonSection
	class FollowButtonSection < GUI::Core::HooView

		attr_accessor :largeButton;

		def initialize( args={} )
			super();

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


			# http://0.0.0.0:3000/widgets/largeSinglebuttonForm
			largeButtonclass =  GUI::HooWidgetList.widgetClass('toggleFormButton')
			@largeButton = largeButtonclass.new( :state=>1 );
			@largeButton.img = '../images/buttons/follow_button/follow-button.png';
			@largeButton.size = [105,45];
			@largeButton.labelStates = ['Follow', 'Follow', 'Unfollow'];
			@largeButton.labelColor = '#fff'
			@largeButton.action = '/widgets/_ajaxPostTest'

			#largeButtonclass =  GUI::HooWidgetList.widgetClass('largeSinglebuttonForm')
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

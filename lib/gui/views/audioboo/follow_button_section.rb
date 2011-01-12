module GUI::Views::Audioboo

    # http://0.0.0.0:3000/widgets/followButtonSection
	class FollowButtonSection < GUI::Core::HooView

		attr_accessor :largeButton;

		def initialize( args={} )
			super();

			largeButtonclass =  GUI::HooWidgetList.widgetClass('largeSinglebuttonForm')
			@largeButton = largeButtonclass.new
			@largeButton.img = '../images/buttons/follow-button.png';
			@largeButton.width = 105;
			@largeButton.height = 45;
			@largeButton.label = 'Follow'
			@largeButton.labelColor = '#fff'

		end

		# Mock Data
		def setupDebugFixture
			super();
		end

	end
end

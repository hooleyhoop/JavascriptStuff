module Gui::Views::Drawing::Buttons::DivButton

	# http://0.0.0.0:3000/widgets/divButtonToggleDynamicWidth
	# http://0.0.0.0:3000/widgets/divButtonToggleDynamicWidth?initialState=1
	# http://0.0.0.0:3000/widgets/divButtonToggleDynamicWidth?initialState=1&cornerRad=20&border=1
	class HooDivButtonToggleDynamicWidth < HooDivButtonToggle

		attr_accessor :cornerRad;
		attr_accessor :border;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:cornerRad=>0, :border=>0} );
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['-Follow-', 'Follow', 'Follow-D', 'Unfollow', 'Unfollow-D'];
			@img = '../images/buttons/toggle-button-dynamic-width/5-state-combine.png';

			# you still need a specific height, otherwise background image wouldnt work.
			@size = [-1, 22];
			@initialState=0 if @initialState==nil
			@cornerRad = 30 if @cornerRad==nil
			@border = 1 if @border==nil
			@labelColor = '#3171d7';
			@action = '/widgets/_ajaxPostTest';
		end
	end
end

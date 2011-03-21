module GUI::Views::Drawing::Buttons::DivButton

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/divButtonSimpleDynamicWidth
	# http://0.0.0.0:3000/widgets/divButtonSimpleDynamicWidth?initialState=1
	# http://0.0.0.0:3000/widgets/divButtonSimpleDynamicWidth?initialState=1&cornerRad=20&border=1
	class HooDivButtonSimpleDynamicWidth < HooDivButtonSimple

		attr_accessor :cornerRad;
		attr_accessor :border;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:cornerRad=>0, :border=>0} );
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed down hard'];
			@img = '../images/buttons/simple-button-dynamic-width/3-state-combine.png';

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

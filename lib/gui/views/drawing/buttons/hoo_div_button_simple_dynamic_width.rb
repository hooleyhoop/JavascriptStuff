module GUI::Views::Drawing::Buttons

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/divButtonSimpleDynamicWidth
	# http://0.0.0.0:3000/widgets/divButtonSimpleDynamicWidth?initailState=1
	class HooDivButtonSimpleDynamicWidth < HooDivButtonSimple

		attr_accessor :cornerRad;
		attr_accessor :border;

		def initialize( args={} )
			super(args);
			if args[:cornerRad]
				@cornerRad=args[:cornerRad].to_i();
			end
			if args[:border]
				@border=args[:border].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button-dynamic-width/3-state-combine.png';

			# you still need a specific height, otherwise background image wouldnt work.
			@size = [-1, 22];
			@initailState=0 if @initailState==nil
			@cornerRad = 30 if @cornerRad==nil
			@border = 1 if @border==nil
			@labelColor = '#3171d7';
			@action = '/widgets/_ajaxPostTest';
			@javascript = "this.hookupAction( function(){
				alert('Holy Cock');
			});";
		end
	end
end

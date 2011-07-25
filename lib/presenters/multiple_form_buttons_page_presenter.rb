module Presenters
	# http://0.0.0.0:3000/pages/multiple_form_buttons_test
	class MultipleFormButtonsPagePresenter < HooPresenter

		include Gui			# Due Care is taken not to make all these methods global

		def initialize( controller )

			super( controller );

			colorFillClass				= widgetClass('HooColorFill')
			li 						= widgetClass("HooLoremIpsumView")
			simpleButton				= widgetClass('HooFormButtonSimple')
			toggleButton				= widgetClass('HooFormButtonSimple')

			@window.showGrid;

			colorFillView = colorFillClass.new()
			@window.contentView.addSubView( colorFillView )

			liInstance = li.new()
			colorFillView.addSubView( liInstance )

			lambda {
				@simpleButton1 = simpleButton.new( :initialState=>1 );
				@simpleButton1.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButton1.size = [105,45];
				@simpleButton1.labelStates = ['-- --', 'Submit', 'Pressed'];
				@simpleButton1.initialState = 1;
				@simpleButton1.labelColor = '#fff'
				@simpleButton1.action = '/widgets/_ajaxPostTest'
				#@simpleButton1.javascript = "this.hookupAction( function(){
				#	alert('Holy Cock');
				#});";
				@window.contentView.addSubView( @simpleButton1 );
			}.call

		end
	end
end

module Presenters
	class HeadlessRecorderPresenter < HooPresenter

		def initialize( controller )

			super( controller )

			@player = widgetClass('detailPlayer').new();
			@window.contentView.addSubView( @player );

			#-------------------------------------------------

			# @recordButton = widgetClass('detailPlayer').new();
			# @playButton = widgetClass('detailPlayer').new();
			# @publishButton = widgetClass('detailPlayer').new();

			# @allowed_duration
			# @recordedDuration
			# @playBackPosition
			# @recordVolume

			# A flippy thing to interact with
			lambda {
				@flippyToggleThingForDebug = widgetClass('flippyToggleThing').new();
				@window.contentView.addSubView( @flippyToggleThingForDebug );
			}.call

			# A basic button
			lambda {
				@simpleButtonForDebug = widgetClass('simpleButton').new( {:initailState => 1} );
				@simpleButtonForDebug.img = '../images/buttons/simple-button/3-state-combine.png';
				@simpleButtonForDebug.size = [105,45];
				@simpleButtonForDebug.labelStates = ['-- --', 'toggle', '** **'];
				@simpleButtonForDebug.labelColor = '#fff';
				@simpleButtonForDebug.action = '/widgets/_ajaxPostTest';
				@simpleButtonForDebug.javascript = "this.hookupAction( function(){
					#{@flippyToggleThingForDebug.varName}.flippyFlip()
				});";

				@window.contentView.addSubView( @simpleButtonForDebug );
			}.call



				headlessRecorder
		end

	end
end

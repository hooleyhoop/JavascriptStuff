module Presenters
	class HeadlessPlayerPresenter < HooPresenter

		def initialize( controller )

			super( controller )

			@player = widgetClass('detailPlayer').new();
			@window.contentView.addSubView( @player );

			#@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			#@window.contentView.addSubView( @spacer );

			#@adam_player = widgetClass('adam_detailPlayer').new();
			#@window.contentView.addSubView( @adam_player );

			#@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			#@window.contentView.addSubView( @spacer );


			# OK - move these components into the player widget.
			@headlessPlayer = widgetClass('headlessPlayer').new({ :url=>'http://0.0.0.0:3000/audio/test.mp3'});
			@window.contentView.addSubView( @headlessPlayer );

			#play pause button
			#time slider

		end



	end
end

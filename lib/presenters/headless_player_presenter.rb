module Presenters

	# http://0.0.0.0:3000/pages/headless_player
	class HeadlessPlayerPresenter < HooPresenter

		def initialize( controller )

			super( controller )

 			detailplayerClass = widgetClass('detailPlayer');

			@player1 = detailplayerClass.new( { :url=>'http://audioboo.fm/boos/12340.mp3'} );
			@window.contentView.addSubView( @player1 );

			@player2 = detailplayerClass.new( { :url=>'http://audioboo.fm/boos/12361.mp3'} );
			@window.contentView.addSubView( @player2 );

			@player3 = detailplayerClass.new( { :url=>'http://audioboo.fm/boos/12525.mp3'} );
			@window.contentView.addSubView( @player3 );



			#@adam_player = widgetClass('adam_detailPlayer').new();
			#@window.contentView.addSubView( @adam_player );

			#@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			#@window.contentView.addSubView( @spacer );

		end



	end
end

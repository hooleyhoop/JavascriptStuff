module Presenters
	class HeadlessPlayerPresenter < HooPresenter

		def initialize( controller )

			super( controller )

			@player = widgetClass('detailPlayer').new();
			@window.contentView.addSubView( @player );


			@spacer = widgetClass('spacerView').new( 100, 10, 10, 10 );
			@window.contentView.addSubView( @spacer );

			@adam_player = widgetClass('adam_detailPlayer').new();
			@window.contentView.addSubView( @adam_player );

		end



	end
end

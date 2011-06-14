module GUI::Views::Debug

    # http://0.0.0.0:3000/widgets/canvasimgresizetest

	class CanvasImgResizeTest < GUI::Core::HooView

		attr_accessor :imgUrl;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:imgUrl=>'http://farm2.static.flickr.com/1013/887300612_044d2e38ed.jpg'} );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

module Gui::Views::Audioboo

    # http://0.0.0.0:3000/widgets/tableHeader
	class TableHeader < Gui::Core::HooView

        attr_accessor :label;
        attr_accessor :color;

		def initialize( args={} )
			super( args );
			@color = 'blue';
		end

        # Mock Data
		def setupDebugFixture
			super();
			@label = 'Data View';
		end

        def image
            img = ''
            if( @color=='blue' )
                img = '/images/table/tableHeader-blue.png';
            elsif(  @color=='lime' )
                img = '/images/table/tableHeader-lime.png';
            elsif(  @color=='orange' )
                img = '/images/table/tableHeader-orange.png';
            elsif(  @color=='pink' )
                img = '/images/table/tableHeader-pink.png';
            end

            return img;
        end

	end
end

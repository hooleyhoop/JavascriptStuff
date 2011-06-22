module Gui::Views::Debug::ScTemplateTests

    # http://0.0.0.0:3000/widgets/dynamic_value_test

	class DynamicValueTest < Gui::Core::HooView

		attr_accessor :linkUrl;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:linkUrl=>'http://apple.com'} );
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end

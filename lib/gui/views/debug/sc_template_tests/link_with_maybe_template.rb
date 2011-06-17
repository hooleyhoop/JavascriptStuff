module GUI::Views::Debug::SCTemplateTests

    # http://0.0.0.0:3000/widgets/linkwithmaybetemplate

	class LinkWithMaybeTemplate < GUI::Core::HooView

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

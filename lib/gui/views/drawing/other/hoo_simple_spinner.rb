module GUI::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/simpleSpinner
	class HooSimpleSpinner < GUI::Core::HooView

		include Test::Unit::Assertions

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {}
		end

	end
end

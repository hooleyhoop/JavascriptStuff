module GUI::Views::Drawing

	# http://0.0.0.0:3000/widgets/simpleSpinner
	class HooSimpleSpinner < GUI::Core::HooView

		include Test::Unit::Assertions

		def initialize( args={} )
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
			}
			return allItems.to_json();
		end

	end
end

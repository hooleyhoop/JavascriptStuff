module GUI::Views::Debug

	# http://0.0.0.0:3000/widgets/mockPlayer
	class MockPlayer < GUI::Core::HooView

	# Mock data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:justAnExample	=> 'grrr',
			}
			return allItems.to_json();
		end

	end
end

module GUI::Views::Debug
	class FlippyToggleThing < GUI::Core::HooView

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

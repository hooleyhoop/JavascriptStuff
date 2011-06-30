module Gui::Views::Debug

	# http://0.0.0.0:3000/widgets/FlippyToggleThing
	class FlippyToggleThing < Gui::Core::HooView

	# Mock data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:justAnExample	=> 'grrr',
			}
		end

	end
end

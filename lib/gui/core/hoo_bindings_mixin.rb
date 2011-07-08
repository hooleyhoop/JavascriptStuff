module Gui::Core::HooBindingsMixin

	def addBinding( aHash )
		@bindings ||= {}
		@bindings.merge!( aHash )
	end

	def addJavascriptAction( aHash )
		@javascriptActions ||= {}
		@javascriptActions.merge!( aHash )
	end

	def addRuntimeObject( aHash )
		@runtimeObjects ||= {}
		@runtimeObjects.merge!( aHash )
	end

end

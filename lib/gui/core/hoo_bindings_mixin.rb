module Gui::Core::HooBindingsMixin

	def addBinding( aHash )
		if(@bindings==nil)
			@bindings = {};
		end
		@bindings.merge!( aHash );
	end

	def addJavascriptAction( aHash )
		if(@javascriptActions==nil)
			@javascriptActions = {};
		end
		@javascriptActions.merge!( aHash );
	end

	def addRuntimeObject( aHash )
		if(@runtimeObjects==nil)
			@runtimeObjects = {};
		end
		@runtimeObjects.merge!( aHash );
	end

end

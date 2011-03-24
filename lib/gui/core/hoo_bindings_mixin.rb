module GUI::Core::HooBindingsMixin

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

end

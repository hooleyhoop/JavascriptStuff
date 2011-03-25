module GUI::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/simpleSlider
	class HooSimpleSlider < GUI::Core::HooView

		include Test::Unit::Assertions
		include GUI::Core::HooBindingsMixin

		attr_accessor :bindings;
		attr_accessor :javascriptActions;

        # Mock Data
		def setupDebugFixture
			super();

			#-- add a checkbox
			mockPlayer = GUI::HooWidgetList.widgetClass('mockPlayer').new()
			chckBox = GUI::HooWidgetList.widgetClass('simpleCheckbox').new( {:label=>'show busy'} )
			chckBox.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>'Holy Cock' }} );

			self.addSubView( mockPlayer );
			self.addSubView( chckBox );

			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>mockPlayer.varName, :action_event=>'setProgressPercent', :action_arg=>'Holy Cock' }} );

			self.addBinding( { :enabledBinding		=>{ :to_taget=>mockPlayer.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			self.addBinding( { :maxAmountValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_duration', :do_action=>'maxAmountDidChange' } } );
			self.addBinding( { :loadedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_loadedValue', :do_action=>'loadedDidChange' } } );
			self.addBinding( { :playedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_playedValue', :do_action=>'playedDidChange' } } );

		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
			}
			allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;

			return allItems.to_json();
		end

	end
end

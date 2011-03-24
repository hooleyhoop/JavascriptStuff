module GUI::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/simpleSlider
	class HooSimpleSlider < GUI::Core::HooView

		include Test::Unit::Assertions
		include GUI::Core::HooBindingsMixin

		attr_accessor :bindings;
		attr_accessor :javascriptActions;

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

			#-- add a checkbox
			mockPlayer = GUI::HooWidgetList.widgetClass('mockPlayer').new()
			chckBox = GUI::HooWidgetList.widgetClass('simpleCheckbox').new( {:label=>'show busy'} )
			chckBox.addJavascriptAction( { :mouseClick=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>'Holy Cock' }} );

			self.addSubView( mockPlayer );
			self.addSubView( chckBox );

			self.addBinding( { :enabledBinding=>{ :enabled_taget=>mockPlayer.varName, :enabled_property=>'_ready', :enabled_action=>'readyDidChange' } } );
			self.addJavascriptAction( { :mouseClick=>{ :action_taget=>mockPlayer.varName, :action_event=>'setProgressPercent', :action_arg=>'Holy Cock' }} );

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

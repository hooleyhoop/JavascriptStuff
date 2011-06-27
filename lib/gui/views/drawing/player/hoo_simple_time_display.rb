module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooSimpleTimeDisplay
	class HooSimpleTimeDisplay < Gui::Core::HooView

		include Test::Unit::Assertions
		include Gui::Core::HooBindingsMixin

		attr_accessor :bindings;
		attr_accessor :javascriptActions;

        # Mock Data
		def setupDebugFixture
			super();

			#-- add a checkbox
			mockPlayer = widgetClass('MockPlayer').new()
			self.addSubView( mockPlayer );

			self.addBinding( { :enabledBinding		=>{ :to_taget=>mockPlayer.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			self.addBinding( { :maxAmountValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_duration', :do_action=>'maxAmountDidChange' } } );
			self.addBinding( { :playedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_playedValue', :do_action=>'playedDidChange' } } );

		end

		# stuff to write into the page
		def jsonProperties
			allItems = {}
			allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;
		end

	end
end

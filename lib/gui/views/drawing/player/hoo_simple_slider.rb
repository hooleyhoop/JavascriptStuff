module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooSimpleSlider
	class HooSimpleSlider < Gui::Core::HooView

		include Test::Unit::Assertions
		include Gui::Core::HooBindingsMixin

		attr_accessor :bindings;
		attr_accessor :javascriptActions;
		attr_accessor :parentCanvas

		def initialize( args={} )
			super(args)
			extractArgs( args, {:parentCanvas=>nil} );
		end

        # Mock Data
		def setupDebugFixture
			super();

			# slider needs a canvas
			# @parentCanvas = widgetClass('HooCanvas').new();
			# addSubView( @parentCanvas );
			# slider creates it's own canvas!

			#-- add a checkbox
			mockPlayer = widgetClass('MockPlayer').new()
			chckBox = widgetClass('HooSimpleCheckbox').new( {:label=>'show busy'} )
			chckBox.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>'', :actionIsAsync=>false }} );

			self.addSubView( mockPlayer );
			self.addSubView( chckBox );

			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>mockPlayer.varName, :action_event=>'setProgressPercent', :action_arg=>'', :actionIsAsync=>false }} );

			self.addBinding( { :enabledBinding		=>{ :to_taget=>mockPlayer.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			self.addBinding( { :maxAmountValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_duration', :do_action=>'maxAmountDidChange' } } );
			self.addBinding( { :loadedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_loadedValue', :do_action=>'loadedDidChange' } } );
			self.addBinding( { :playedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_playedValue', :do_action=>'playedDidChange' } } );

		end

		# stuff to write into the page
		def jsonProperties

			#self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });

			allItems = {
			}

			allItems.merge!( { :bindings => @bindings } ) unless @bindings.nil?
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions.nil?
			return allItems

		end

	end
end

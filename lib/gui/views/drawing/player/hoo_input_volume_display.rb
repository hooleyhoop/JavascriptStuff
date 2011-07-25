module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooInputVolumeDisplay
	# http://0.0.0.0:3000/widgets/HooInputVolumeDisplay?outerRad=0.99&innerRad=0.8
	class HooInputVolumeDisplay <  Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		attr_accessor :parentCanvas
		attr_accessor :outerRad
		attr_accessor :innerRad

		def initialize( args={} )
			super(args)
			extractArgs( args, {:parentCanvas=>nil, :outerRad=>1.0, :innerRad=>0.5} )
		end

        # Mock Data
		def setupDebugFixture
			super()

			# playPauseButton needs a canvas
			@parentCanvas = widgetClass('HooCanvas').new()
			addSubView( @parentCanvas )

			@sndInput = widgetClass('MockInputSource').new()
			addSubView( @sndInput )

			self.addBinding( { :enabledBinding		=>{ :to_taget=>@sndInput.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			self.addBinding( { :loadedValueBinding	=>{ :to_taget=>@sndInput.varName, :to_property=>'_soundlevel', :do_action=>'sndLevelDidChange' } } );
		end


		def jsonProperties

			#TODO: This cannot stay here!
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName });

			allItems = {
				:outerRad => @outerRad,
				:innerRad => @innerRad
			}

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects.nil?
			allItems.merge!( { :bindings => @bindings } ) unless @bindings.nil?
			return allItems

		end

	end
end

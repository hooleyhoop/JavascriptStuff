module Gui::Views::Players

	# http://0.0.0.0:3000/widgets/HooHtml5DetailPlayer
	# http://shooley.audioboo.fm:3000/widgets/HooHtml5DetailPlayer

	class HooHtml5DetailPlayer < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

        attr_accessor :layoutView, :playButtonCanvas, :playButton, :timeDisplay, :slider
		attr_accessor :mp3Url

		def initialize( args={} )
			super args
			extractArgs( args, {:mp3Url=>'http://audioboo.fm/boos/393446-converting-arr-to-mp3-for-an-audioboo.mp3'} );

			#-- add a checkbox
			#mockPlayer = widgetClass('MockPlayer').new()
			#self.addSubView( mockPlayer );

			@layoutView = widgetClass('DetailPlayerLayout').new( {fixedColSide:'left', fixedColWidth:90} )
			self.addSubView( @layoutView )

            # playPauseButton needs a canvas
            @playButtonCanvas = widgetClass('HooCanvas').new()

			@playButton = widgetClass('HooPlayPauseButton').new( {:parentCanvas=>@playButtonCanvas, :percentOfCanvas=>0.9 } )
			@slider = widgetClass('HooSimpleSlider').new()
			@timeDisplay = widgetClass('HooSimpleTimeDisplay').new()

			timeDisplaySpacer = widgetClass('HooSpacerView').new( {top:15} )
			timeDisplaySpacer.addSubView( @timeDisplay )

			@layoutView.addSubviews( @playButtonCanvas, timeDisplaySpacer, @slider )

			# These dont occuoy space but must be in the view hierachy
			#@action = 'http://audioboo.fm';
			@playButtonCanvas.addSubView( @playButton )

			#-- configure actions
			#@playButton.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooLog', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );

			# @timeDisplay.addBinding( { :enabledBinding			=>{ :to_taget=>mockPlayer.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			# @timeDisplay.addBinding( { :maxAmountValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_duration', :do_action=>'maxAmountDidChange' } } );
			# @timeDisplay.addBinding( { :playedValueBinding		=>{ :to_taget=>mockPlayer.varName, :to_property=>'_playedValue', :do_action=>'playedDidChange' } } );

			#@slider.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>mockPlayer.varName, :action_event=>'setProgressPercent', :action_arg=>'', :actionIsAsync=>false }} );
			#@slider.addBinding( { :enabledBinding		=>{ :to_taget=>mockPlayer.varName, :to_property=>'_ready', :do_action=>'readyDidChange' } } );
			#@slider.addBinding( { :maxAmountValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_duration', :do_action=>'maxAmountDidChange' } } );
			#@slider.addBinding( { :loadedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_loadedValue', :do_action=>'loadedDidChange' } } );
			#@slider.addBinding( { :playedValueBinding	=>{ :to_taget=>mockPlayer.varName, :to_property=>'_playedValue', :do_action=>'playedDidChange' } } );
		end


        # Mock Data
       # def setupDebugFixture
        	#super
        	#@layoutView.setupDebugFixture
			#self.addSubviews( widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new() )
       #end

		def jsonProperties
			self.addRuntimeObject({:_playButtonCanvas=>@playButtonCanvas.varName, :_playButton=>@playButton.varName, :_slider=>@slider.varName, :_timeDisplay=>@timeDisplay.varName })
			allItems = {
				:mp3Url	=> @mp3Url
			}

			#TODO: This is all fucked! wshy do i have to duplicate this everywhere? Easy to sort out
			# - get custom items
			# - conditionally merge bindings
			# - conditionally merge actions
			# - seperate out items that require swapping at runtime

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects.nil?
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions.nil?

			return allItems
		end

	end
end

module Gui::Views::Drawing::Player

	# http://0.0.0.0:3000/widgets/HooBarberPole
	class HooBarberPole < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		attr_accessor :parentCanvas

		def initialize( args={} )
			super(args)
			extractArgs( args, {:parentCanvas=>nil} )
		end

        # Mock Data
		def setupDebugFixture
			super()
			@parentCanvas = widgetClass('HooCanvas').new()
			addSubView( @parentCanvas )

			@chckbx1 = widgetClass('HooSimpleCheckbox').new( {:label=>'show busy'} )
			addSubView( @chckbx1 )
			@chckbx1.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>nil, :actionIsAsync=>false  }} )
		end

		def jsonProperties
			self.addRuntimeObject({:_hooCanvas => @parentCanvas.varName })
			allItems = {
			}

			#TODO: This is all fucked! wshy do i have to duplicate this everywhere? Easy to sort out
			# - get custom items
			# - conditionally merge bindings
			# - conditionally merge actions
			# - seperate out items that require swapping at runtime

			allItems.merge!( { :runtimeObjects => @runtimeObjects } ) unless @runtimeObjects.nil?
			return allItems
		end
	end
end

module Gui::Views::Players

	# http://0.0.0.0:3000/widgets/HooFlashSmallRecorder
	# http://shooley.audioboo.fm:3000/widgets/HooFlashSmallRecorder

	class HooFlashSmallRecorder < Gui::Core::HooView

       # attr_accessor :parentCanvas

		def initialize( args={} )
			super args

           ##@parentCanvas = widgetClass('HooCanvas').new()
    	   ## addSubView( @parentCanvas )
		end


        # Mock Data
       # def setupDebugFixture
        	#super
        	#@layoutView.setupDebugFixture
			#self.addSubviews( widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new() )
       #end

	end
end

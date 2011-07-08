require "action_view"

module Presenters
	class HooPresenter

		attr_accessor :window, :controller;

		def initialize( controller )

			super();
			@controller = controller
	    	@window = Gui::Core::HooWindow.new()

	    	#-- assert rails 2 only
	    	if( Rails::VERSION::MAJOR == 2 )
	    	    raise "upgrade you shitcock"
	    	    controller.extend ActionControllerBaseExtensions
	    	    @controller.window = @window;
	    	    @controller.class.helper( HooGuiHelper )
            end

		end

		def drawPage()
			@window.drawNow( @controller );
		end

		#def render(options = {}, locals = {}, &block)
		#	Rails.logger.info @controller==nil
		#end

		def layoutClass( layoutName )
			Gui::HooWidgetList.layoutClass( layoutName );
		end

		def widgetClass( widgetName )
			Gui::HooWidgetList.widgetClass( widgetName );
		end

		def cellClass( cellName )
			Gui::HooWidgetList.cellClass( cellName );
		end

	end
end


module ActionControllerBaseExtensions

	attr_accessor :window;

	def display( settings )
	    if( Rails::VERSION::MAJOR == 2 )
	        raise "you have made an awful, awful, awful mistake. You shouldn't even be here in Rails 3 and above"
        end

		self.render( settings );
	end

end

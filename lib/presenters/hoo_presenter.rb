require "action_view"

module Presenters
	class HooPresenter

		attr_accessor :window, :controller;

		def initialize( controller )
			super();
			@controller = controller;
	    @window = GUI::Core::HooWindow.new();
		end


		def drawPage()
			@window.drawNow( @controller );
		end

		#def render(options = {}, locals = {}, &block)
		#	Rails.logger.info @controller==nil
		#end

		def layoutClass( layoutName )
			GUI::HooWidgetList.layoutClass( layoutName );
		end

		def widgetClass( widgetName )
			GUI::HooWidgetList.widgetClass( widgetName );
		end

		def cellClass( cellName )
			GUI::HooWidgetList.cellClass( cellName );
		end

	end
end

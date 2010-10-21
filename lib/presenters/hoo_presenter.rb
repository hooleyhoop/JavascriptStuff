require "action_view"

module Presenters
	class HooPresenter < ActionView::Base

		attr_accessor :window, :controller;

		def initialize( controller )	
			super();
			@controller = controller;
	    @window = GUI::HooWindow.new();
		end


		def drawPage()
			@window.drawNow( @controller );
		end
		
		#def render(options = {}, locals = {}, &block)
		#	Rails.logger.info @controller==nil
		#end
				
	end
end

require "action_view"

module Presenters
	class HooPresenter < ActionView::Base

		attr_accessor :window, :controller;

		def initialize( controller )	
			super();
			@controller = controller;
	    	@window = GUI::HooWindow.new();
		end
	
	end
end

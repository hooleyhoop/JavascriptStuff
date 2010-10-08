module Presenters
	class WidgetsPagePresenter < HooPresenter

			attr_accessor :window

			def initialize( controller ) # *vals
				#super( vals )
				#vals.each do |i|
				#end
				#Rails.logger.info vals[2];

	    	@controller = controller;
	    	@window = GUI::HooWindow.new();
	    	@bluView = GUI::HooBlueView.new();
	    	@redView = GUI::HooRedView.new();
	    	@bluView.addSubView( @redView );
	    	@window.addSubView( @bluView );
			end

			def drawPage()
				@window.drawNow( @controller );
			end

			#def render(options = {}, locals = {}, &block)
			#	Rails.logger.info @controller==nil
			#end
	end
end

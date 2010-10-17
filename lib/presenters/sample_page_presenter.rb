module Presenters
	class SamplePagePresenter < HooPresenter

		def initialize( controller )
		
			super( controller )
			
			@colView = GUI::HooElasticColView.new();

			@colView.header = GUI::HooLoremIpsum.new();
			@colView.footer = GUI::HooLoremIpsum.new();
			@colView.mainColumn = GUI::HooLoremIpsum.new();
			@colView.sidebar = GUI::HooLoremIpsum.new();

			@window.addSubView( @colView );
		end

		def drawPage()
			@window.drawNow( @controller );
		end

		#def render(options = {}, locals = {}, &block)
		#	Rails.logger.info @controller==nil
		#end
	end
end

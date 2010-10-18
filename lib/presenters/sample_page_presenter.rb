module Presenters
	class SamplePagePresenter < HooPresenter

		def initialize( controller )
		
			super( controller )
			
			@colView = GUI::HooElasticColView.new( {:sideBarEmWidth=>15} );

			@colView.header = GUI::HooLoremIpsum.new();
			@colView.footer = GUI::HooLoremIpsum.new();
			@colView.mainColumn = GUI::HooLoremIpsum.new();
			@colView.sidebar = GUI::HooLoremIpsum.new();

			@window.addSubView( @colView );
		end

		def drawPage()
			@window.drawNow( @controller );
		end

	
	end
end

module Presenters
	class WidgetsPagePresenter < HooPresenter

		def initialize( controller )
				
			super( controller );
			
	    	@colView = GUI::HooElasticColView.new();

	    	@window.addSubView( @colView );

	    	#@bluView = GUI::HooBlueView.new();
	    	#@redView = GUI::HooRedView.new();
	    	#@bluView.addSubView( @redView );
	    	#@window.addSubView( @bluView );
		end



	end
end

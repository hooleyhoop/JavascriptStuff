module Presenters
	class WidgetsPagePresenter < HooPresenter

		def initialize( controller )
				
			super( controller );
			
			  allWidgets = [
			    "GUI::HooBlueView",
			    "GUI::HooRedView",
			    "GUI::HooInfoOneView",
			    "GUI::HooLoremIpsumView",
			    "GUI::HooLoremIpsumTitleView",
			    "GUI::HooPullQuoteOneView"
		    ];
		    
			  # lets lay out all widgets
			  
			  allWidgets.each do |widget|
			    classFromString = widget.constantize
			    instance = classFromString.new()
			    instance.setupDebugFixture()
    			@window.contentView.addSubView( instance );
			  end
			  
	      # some view can be nested
      	bluView = GUI::HooBlueView.new();
        bluView.setupDebugFixture();
	    	redView = GUI::HooRedView.new();
	    	redView.setupDebugFixture();
        
	    	bluView.addSubView( redView );
  			@window.contentView.addSubView( bluView );
  			
	    	
		end



	end
end

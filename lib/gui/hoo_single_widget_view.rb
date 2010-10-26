module GUI
	class HooSingleWidgetView < HooView

		attr_accessor :textList, :widgetResizer;

		def initialize()
			super();

			@menuItems = [
				{ 'name'=>"loremIpsum", 'url'=>GUI::HooLoremIpsumView.name},
				{ 'name'=>"loremIpsumTitle", 'url'=>GUI::HooLoremIpsumTitleView.name},
				{ 'name'=>"Info One", 'url'=>GUI::HooInfoOneView.name},
				{ 'name'=>"Pull Quote", 'url'=>GUI::HooPullQuoteOneView.name},
			];

			@textList = GUI::HooTextListView.new();
			@textList.dataSrc = self;

			@widgetResizer = GUI::HooWidgetResizerView.new();
			@widgetResizer.dataSrc = self;
      
      #TODO:
      # i thought this was going to go?
      # Instead, when we click on a menu item change the currentItem in the controller
      # and send a notification that something changed to the widget view
      @textList.target = @widgetResizer

			addSubView( @textList );
			addSubView( @widgetResizer );
			
		end

    def wasAddedToParentView
      super();
  		RAILS_DEFAULT_LOGGER.info self.window
			self.window.installStartupJavascript( :function=>"crippleListView", :arg1=>"fuck right off" );
			
			finish this! why doesnt it work?
		  then injecting javascrip
		  then bindings
		  then column view
		  
    end
    
		def allItems
			return @menuItems;
		end

		def defaultItem
			return @menuItems.first['url'];
		end

	end
end

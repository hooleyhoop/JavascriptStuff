module GUI::Views
	class HooSingleWidgetView < GUI::Core::HooView

    attr_accessor :menuItems
		attr_accessor :textList, :widgetResizer;

		def initialize()
			super();

			@setTransparencyButton = HooLabeledButton1.new();

			@textList = HooTextListView.new();
			@textList.dataSrc = self;

			@widgetResizer = HooWidgetResizerView.new();
			@widgetResizer.dataSrc = self;

			addSubView( @setTransparencyButton );
			addSubView( @textList );
			addSubView( @widgetResizer );

		end

    def setupDebugFixture
      super();
   		@menuItems = [
				{ 'name'=>"loremIpsum", 'url'=>HooLoremIpsumView.name},
				{ 'name'=>"loremIpsumTitle", 'url'=>HooLoremIpsumTitleView.name},
				{ 'name'=>"Info One", 'url'=>HooInfoOneView.name},
				{ 'name'=>"Pull Quote", 'url'=>HooPullQuoteOneView.name},
				{ 'name'=>"List View", 'url'=>HooListOneView.name}

			];
			end

    def wasAddedToParentView
      super();

      # Hack on some javascript to modify the behavoir of the list view
      # This script removes the links from the listView items and replaces them with calls
      # to widgetResizer's actionName with the previous url value as an argument (for ajax purposes)

      #TODO: In the future!
      #These GUI objects should exist in the javascript
      #When the list item is clicked, instead of hooking it up to call widgetResizer.actionName it should just change
      #the value in the model (the javascript representation of this object). widgetResizer would be observing
      #this value
			self.window.installStartupJavascript( :function=>"crippleListView", :arg1=>@textList.uniqueSelector(), :arg2=>@widgetResizer.actionName );
    end

		def allItems
			return @menuItems;
		end

		def defaultItem
			return @menuItems.first['url'];
		end

	end
end

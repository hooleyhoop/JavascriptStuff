module Gui::Views::Debug::WidgetPreview

	# http://0.0.0.0:3000/widgets/singleWidget
	class HooSingleWidgetView < Gui::Core::HooView

    attr_accessor :menuItems
    attr_accessor :textList, :widgetResizer;

	def self.dslName() 'singleWidget' end

    def initialize( defaultWidget='', optionalArgs={} )
        super()

        @hasDefaultWidget = (defaultWidget=='') ? false : true;

        @widgetResizer = widgetClass('widgetResizer').new();
        @widgetResizer.dataSrc = self;

        @setTransparencyButton = widgetClass('labeledButton').new();
        addSubView( @setTransparencyButton );

        # dont show textlist if we have a default widget
        if( @hasDefaultWidget==false )
            @textList = HooTextListView.new();
            @textList.dataSrc = self;
            addSubView( @textList );
        end

        addSubView( @widgetResizer );

        #only temp resizable content
        if( @hasDefaultWidget )
            defaultWidgetClass = widgetClass( defaultWidget );
            tempRsizerContent = defaultWidgetClass.new( optionalArgs );
            tempRsizerContent.setupDebugFixture();
            @widgetResizer.addSubView( tempRsizerContent );
       end

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
        if( @hasDefaultWidget==false )
            self.window.installStartupJavascript( :function=>"crippleListView", :arg1=>@textList.uniqueSelector(), :arg2=>@widgetResizer.actionName );
        end
    end

		def allItems
			return @menuItems;
		end

		def defaultItem
			return @menuItems.first['url'];
		end

	end
end

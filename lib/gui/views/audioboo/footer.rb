module GUI::Views::Audioboo

	class Footer < GUI::Core::HooView

        attr_accessor :allItems;

        # You must build your elements in initialize, even if conditional.
        # Therefor you must pass the conditional data to initialize
		def initialize( args={} )
			super();
		end

        # Mock Data
        def setupDebugFixture
            super();
        end

		def wasAddedToParentView
		    super();

                allItems.each do |item|



                    #spacerViewClass = GUI::HooWidgetList.widgetClass('spacerView');
                    #spacerView = spacerViewClass.new( 0, 0, 10, 5 );

                textListClass = GUI::HooWidgetList.widgetClass('textList1');
                listView = textListClass.new();
                listView.dataSrc = listView;
                listView.allItems = item;
                listView.size = 'small';

             #   spacerView.addSubView( @listView );
                self.addSubView( listView );
                end

        end

	end
end

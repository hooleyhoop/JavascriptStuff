module GUI::Views::Audioboo

	class TableList < GUI::Core::HooView

        attr_accessor :menuItems;

        # You must build your elements in initialize, even if conditional.
        # Therefor you must pass the conditional data to initialize
		def initialize( args={} )
			super();
			if( args.has_key?(:style) )
			    @style = args[:style]
			else
			    @style = 'textList'
			end

            tableHeaderClass = GUI::HooWidgetList.widgetClass('tableHeader');
            @header = tableHeaderClass.new();
            self.addSubView( @header );

            if @style=='continuousText'
                textListClass = GUI::HooWidgetList.widgetClass('inlineTextList');
                @textList = textListClass.new();
                @textList.dataSrc = self;
                @textList.size = 'small';
                self.addSubView( @textList );

            elsif @style=='textList'
                textListClass = GUI::HooWidgetList.widgetClass('textList1');
                @textList = textListClass.new();
                @textList.dataSrc = self;
                @textList.size = 'small';
                self.addSubView( @textList );
            end
		end

        # Mock Data
		def setupDebugFixture
			super();
            self.label = 'smelly wagstaff'
            self.color = 'pink';
            @style = 'textList';
            self.menuItems = [
				{ 'name'=>"shanty town",     		'url'=> "shabba" },
				{ 'name'=>"just a fool for",      	'url'=> "shabba" },
				{ 'name'=>"rocket",        			'url'=> "shabba" },
				{ 'name'=>"fur pine coat dog",    	'url'=> "shabba" },
			];
		end

		def wasAddedToParentView
		    super();
        end

        def label=( labelTxt )
            @header.label = labelTxt;
        end

        def color=( col )
            @header.color = col;
        end

		def allItems
			@menuItems
		end

	end
end

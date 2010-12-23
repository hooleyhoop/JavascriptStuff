module GUI::Views::Audioboo

	class TableList < GUI::Core::HooView

        attr_accessor :content;

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
                inlineTextListClass = GUI::HooWidgetList.widgetClass('inlineTextList');
                @listView = inlineTextListClass.new();
                @listView.dataSrc = self;
                @listView.size = 'small';
                self.addSubView( @listView );

            elsif @style=='textList'
                textListClass = GUI::HooWidgetList.widgetClass('textList1');
                @listView = textListClass.new();
                @listView.dataSrc = self;
                @listView.size = 'small';
                self.addSubView( @listView );

            elsif @style=='cell'
                listClass = GUI::HooWidgetList.widgetClass('spacedCellList');
                @listView = listClass.new();
                @listView.cell = GUI::HooWidgetList.cellClass('sparseBooCell').new()
                @listView.dataSrc = self;
                @listView.mapping = {
				    '@heading'=>'username',
				    '@subHeading'=>'title',
				    '@imgPath'=>'booPicPath',
			    }
                self.addSubView( @listView );

            end
		end

        # Mock Data
		def setupDebugFixture
			super();
            self.label = 'smelly wagstaff'
            self.color = 'pink';
            @style = 'textList';
            self.content = [
				{ 'name'=>'shanty town',     		'url'=> 'shabba' },
				{ 'name'=>'just a fool for',      	'url'=> 'shabba' },
				{ 'name'=>'rocket',        			'url'=> 'shabba' },
				{ 'name'=>'fur pine coat dog',    	'url'=> 'shabba' },
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
			self.content
		end

	end
end

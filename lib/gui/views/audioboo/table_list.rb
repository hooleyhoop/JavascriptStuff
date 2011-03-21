module GUI::Views::Audioboo

	# http://0.0.0.0:3000/widgets/tableList
	class TableList < GUI::Core::HooView

        attr_accessor :content;
        attr_accessor :backgroundColor;

        # You must build your elements in initialize, even if conditional.
        # Therefor you must pass the conditional data to initialize
		def initialize( args={} )
			super(args);

            @backgroundColor = '#ffffff'

			if( args.has_key?(:style) )
			    @style = args[:style]
			else
			    @style = 'textList'
			end

            tableHeaderClass = GUI::HooWidgetList.widgetClass('tableHeader');
            @header = tableHeaderClass.new();
            self.addSubView( @header );

            if @style=='continuousText'
                # list needs some spacing
                spacerViewClass = GUI::HooWidgetList.widgetClass('spacerView');
                spacerView = spacerViewClass.new( 0, 0, 5, 5 );

                inlineTextListClass = GUI::HooWidgetList.widgetClass('inlineTextList');
                @listView = inlineTextListClass.new();
                @listView.dataSrc = self;
                @listView.size = 'small';

                spacerView.addSubView( @listView );
                self.addSubView( spacerView );

            elsif @style=='textList'

                # list needs some spacing
                spacerViewClass = GUI::HooWidgetList.widgetClass('spacerView');
                spacerView = spacerViewClass.new( 0, 0, 10, 5 );

                textListClass = GUI::HooWidgetList.widgetClass('textList1');
                @listView = textListClass.new();
                @listView.dataSrc = self;
                @listView.size = 'small';

                spacerView.addSubView( @listView );
                self.addSubView( spacerView );

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

            if( @style == 'textList' )
                self.content = [
                    { 'name'=>'shanty town',     		'url'=> 'shabba' },
                    { 'name'=>'just a fool for',      	'url'=> 'shabba' },
                    { 'name'=>'rocket',        			'url'=> 'shabba' },
                    { 'name'=>'fur pine coat dog',    	'url'=> 'shabba' },
                    ];

            elsif( @style == 'cell' )
                self.content = [
                    { 'username' =>'lonnyjihnnygon',     'title'=> 'Syncopated Clock by daughters second grade class',   'booPicPath'=> '../images/user/my_pic.png' },
                    { 'username' =>'daredevel',          'title'=> 'When the levy breaks',                               'booPicPath'=> '../images/user/my_pic.png'  },
                    { 'username' =>'hooleyhooppe',       'title'=> 'choo choo choose me',                                'booPicPath'=> '../images/user/my_pic.png'  },
                ];
            end
        end

		def wasAddedToParentView
		    super();
        end

        def label=( labelTxt )
            @header.label = labelTxt;
        end

        # we could do weith some kind of colour helper class
        def color=( col )
            @header.color = col;
            if( col=='blue' )
                @backgroundColor = '#e4eeff'
            elsif(  col=='lime' )
                @backgroundColor = '#dbe8b3'
            elsif(  col=='orange' )
                @backgroundColor = '#ffeed6'
            elsif(  col=='pink' )
                @backgroundColor = '#f9e4f1'
            end
        end

		def allItems
			self.content
		end

	end
end

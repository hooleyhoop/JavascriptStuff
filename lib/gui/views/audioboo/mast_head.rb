module GUI::Views::Audioboo

	# http://0.0.0.0:3000/widgets/mastHead
	class MastHead < GUI::Core::HooView

		attr_accessor :allItems;

		# You must build your elements in initialize, even if conditional.
		# Therefor you must pass the conditional data to initialize
		def initialize( args={} )
			super(args);
			fourColClass = GUI::HooWidgetList.widgetClass('4col');
			@fourColView = fourColClass.new();
			self.addSubView( @fourColView );
		end

		# Mock Data
		def setupDebugFixture
			super();
			self.allItems = [

			[   { 'text' =>'About Us',     'link'=> '#' },
			{ 'text' =>'Audioboo Pro',     'link'=> '#' },
			{ 'text' =>'Developers',     'link'=> '#' },
			{ 'text' =>'Widgets',     'link'=> '#' }, ],

			[   { 'text' =>'Support/Discussion',     'link'=> '#' },
			{ 'text' =>'Community Guidelines',     'link'=> '#' },
			{ 'text' =>'Terms & Conditions',     'link'=> '#' },
			{ 'text' =>'Privacy Policy',     'link'=> '#' }, ],

			[   { 'text' =>'Quick Tour',     'link'=> '#' },
			{ 'text' =>'Watch a video intro',     'link'=> '#' },
			{ 'text' =>'Follow us on Twitter',     'link'=> '#' },
			{ 'text' =>'Join our Facebook Group',     'link'=> '#' }, ],

			[   { 'text' =>'Latest from the blog',     'link'=> '#' },
			{ 'text' =>'iPhone App 2.0',     'link'=> '#' },
			{ 'text' =>'RIP 4IP',     'link'=> '#' },
			{ 'text' =>'audioMo',     'link'=> '#' }, ],
			];
        end

		def wasAddedToParentView
			super();

			textListClass = GUI::HooWidgetList.widgetClass('textList1');

			# NB) limited to exactly 4 cols at the moment
			allItems.each do |item|



                    #spacerViewClass = GUI::HooWidgetList.widgetClass('spacerView');
                    #spacerView = spacerViewClass.new( 0, 0, 10, 5 );

                listView = textListClass.new();
                listView.dataSrc = listView;
                listView.allItems = item;
                listView.size = 'small';

             #   spacerView.addSubView( @listView );
				@fourColView.addSubView( listView );
			end

		end

	end
end

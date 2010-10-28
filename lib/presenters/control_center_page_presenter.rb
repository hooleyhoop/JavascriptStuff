module Presenters
	class ControlCenterPagePresenter < HooPresenter

		def initialize( controller )
				
			super( controller );
			
			@menuItems = [
				{ 'name'=>"javascript tests",     'url'=> controller.pages_javascript_unit_tests_path },
				{ 'name'=>"widgets",              'url'=> controller.pages_widgets_path },
				{ 'name'=>"single widget",        'url'=> controller.pages_single_widget_path },
				{ 'name'=>"sample fixed page",    'url'=> controller.pages_sample_fixed_page_path },				
				{ 'name'=>"sample elastic page",  'url'=> controller.pages_sample_elastic_page_path },
				{ 'name'=>"grid view",            'url'=> controller.pages_grid_view_path },
				{ 'name'=>"elephant view",        'url'=> controller.elephants_path }
				
			];

			@textList = GUI::HooTextListView.new();
			@textList.dataSrc = self;
			
			@window.contentView.addSubView( @textList );
			
		end

		def allItems
			return @menuItems;
		end

	end
end

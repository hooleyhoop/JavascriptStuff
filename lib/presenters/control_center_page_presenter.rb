module Presenters
	class ControlCenterPagePresenter < HooPresenter

		def initialize( controller )

			super( controller );

			@menuItems = [
				{ 'name'=>"javascript tests",		'url'=> controller.pages_javascript_unit_tests_path },
				{ 'name'=>"widgets",				'url'=> controller.pages_widgets_path },
				{ 'name'=>"single widget",			'url'=> controller.pages_single_widget_path },
				{ 'name'=>"sample fixed page",		'url'=> controller.pages_sample_fixed_page_path },
				{ 'name'=>"sample elastic page",	'url'=> controller.pages_sample_elastic_page_path },
				{ 'name'=>"grid view",				'url'=> controller.pages_grid_view_path },
				{ 'name'=>"list view",				'url'=> controller.pages_list_view_path },
				{ 'name'=>"horizontal list view",	'url'=> controller.pages_horizontal_list_view_path },
				{ 'name'=>"elephant view",			'url'=> controller.elephants_path },
				{ 'name'=>"audiobooScratchPad",		'url'=> controller.pages_test_audioboo_stuff_path },
				{ 'name'=>"all the buttons",		'url'=> controller.pages_multiple_buttons_test_path },

			];

			@importantMessage = widgetClass('bigWord').new( 'Views should be logic-less' );
			@window.contentView.addSubView( @importantMessage );

			@textList = widgetClass('textList1').new()
			@textList.dataSrc = self;

			@window.contentView.addSubView( @textList );

		end

		def allItems
			return @menuItems;
		end

	end
end

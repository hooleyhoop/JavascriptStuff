module GUI
	class HooSingleWidgetView < HooView

		attr_accessor :textList, :widgetResizer;

		def initialize()
			super();

			@menuItems = [
				{ 'name'=>"loremIpsum", 'url'=>GUI::HooLoremIpsumView.name},
				{ 'name'=>"loremIpsumTitle", 'url'=>GUI::HooLoremIpsumTitleView.name},
				{ 'name'=>"HooInfoOne", 'url'=>GUI::HooInfoOne.name},
			];

			@textList = GUI::HooTextListView.new();
			@textList.dataSrc = self;

			@widgetResizer = GUI::HooWidgetResizerView.new();
			@widgetResizer.dataSrc = self;

      		@textList.target = @widgetResizer

		end

		def allItems
			return @menuItems;
		end

		def defaultItem
			return @menuItems.first['url'];
		end

	end
end

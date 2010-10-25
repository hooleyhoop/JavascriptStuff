module GUI
	class HooSingleWidgetView < HooView

		attr_accessor :textList, :widgetResizer;

		def initialize()
			super();
			
			@textList = GUI::HooTextListView.new();
      @widgetResizer = GUI::HooWidgetResizerView.new();
    
		end

	end
end

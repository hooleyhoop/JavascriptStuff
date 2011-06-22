module Gui::Views::Debug::WidgetPreview

	# http://0.0.0.0:3000/widgets/widgetResizer
	class HooWidgetResizerView < Gui::Core::HooView

    attr_accessor :dataSrc;
    attr_accessor :actionName

		def initialize(args={})
			super(args);
			@actionName = :loadSomeHTMLByAjax2;
		end

	end
end

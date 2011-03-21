module GUI::Views::Debug
	class HooWidgetResizerView < GUI::Core::HooView

    attr_accessor :dataSrc;
    attr_accessor :actionName

		def initialize
			super();
			@actionName = :loadSomeHTMLByAjax2;
		end

	end
end

module GUI::Views
	class HooLabeledButton1 < GUI::Core::HooView

		attr_accessor :label;
		attr_accessor :action;

		def initialize( labelString="empty label" )
			super();
			@label = labelString
			@action = 'hackColors'
		end

	end
end

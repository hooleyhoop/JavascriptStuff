module Gui::Views::Unsorted

	# http://0.0.0.0:3000/widgets/labeledButton
	class HooLabeledButton1 < Gui::Core::HooView

		attr_accessor :label;
		attr_accessor :action;

		def initialize( labelString="empty label" )
			super();
			@label = labelString
			@action = 'hackColors'
		end

	end
end

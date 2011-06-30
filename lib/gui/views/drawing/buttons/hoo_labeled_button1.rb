module Gui::Views::Drawing::Buttons

	# http://0.0.0.0:3000/widgets/HooLabeledButton1
	class HooLabeledButton1 < Gui::Core::HooView

		attr_accessor :label;
		attr_accessor :action;

		def self.dslName() 'labeledButton' end

		def initialize( labelString="empty label" )
			super()
			@label = labelString
			@action = 'hackColors'
		end

	end
end

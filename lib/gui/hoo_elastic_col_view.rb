module GUI
	class HooElasticColView < HooView

		attr_accessor :header, :footer, :mainColumn, :sidebar

		def initialize
			super();
			@header = GUI::HooBlueView.new();
		end

	end
end

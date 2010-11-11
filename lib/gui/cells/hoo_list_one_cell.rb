module GUI::Cells
	class HooListOneCell < Object

		attr_accessor :mapping, :heading, :subHeading;

		def initialize()
			super();
		end

		def partial
			"gui/cells/hoo_list_one_cell"
		end

		def mapping=( arg )
			@mapping = arg
			@mapping.each_pair{|key, value| instance_variable_set(key,value)}
		end

	end
end

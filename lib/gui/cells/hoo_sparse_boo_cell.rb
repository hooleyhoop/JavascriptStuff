module GUI::Cells
	class HooSparseBooCell < Object

		attr_accessor :mapping;
		attr_accessor :heading, :subHeading, :imgPath;

		def initialize()
			super();
		end

		def partial
			"gui/cells/hoo_sparse_boo_cell"
		end

		def mapping=( arg )
			@mapping = arg
			@mapping.each_pair{|key, value| instance_variable_set(key,value)}
		end

	end
end

module GUI::Core
	class HooCell < Object

        attr_accessor :mapping

		def partial
		    return self.class.to_s.underscore
		end

		def mapping=( arg )
			@mapping = arg
			@mapping.each_pair{|key, value| instance_variable_set(key,value)}
		end

	end
end

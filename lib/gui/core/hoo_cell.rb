module GUI::Core
	class HooCell < Object

        attr_accessor :currentIndex
        attr_accessor :mapping

        # when rendering the cell (the cell is share between each item) dataSrc is the current item
        attr_accessor :dataSrc

		def initialize( args={} )
			super(args);
			@currentIndex = 0;
		end

		def self.partial_path
			#NB if we didnt want the GUI/ prefix we could do  name.split('::').last || ''
			return self.name.underscore;
		end

		def partial
		    return self.class.to_s.underscore
		end

		def self.model_name
			return self;
		end

		# gui_hoo_text_list_view_2168956940
		def uniqueSelector
			className = self.class.to_s
			className = className.gsub('::','_')
			textListSelector = '#' + className.underscore + '_'+ self.object_id.to_s
		end

        # which key in the dataSrc is heading, which key is emailPath? etc.
		def mapping=( arg )
			@mapping = arg
			@mapping.each_pair{|key, value| instance_variable_set(key,value)}
		end

        # deference self.ivar value in dataSrc
        # ie dataSrc is a hash with a value for key :email
        # self.heading = 'email'
        # so return self.dataSrc[self.heading]
        def [](ivar)
            dataSrcKey = self.instance_variable_get("@#{ivar}");
            return dataSrc[dataSrcKey];
        end

        # called each time we render the cell.. any use?
        def insert( parent, item )
            @currentIndex = @currentIndex + 1
            return parent.render( :partial=>self.partial, :object=>item, :locals=>{ :_ => self } );
        end

		# this can be used instead of a haml file
		def stringOutput
		end

	end
end

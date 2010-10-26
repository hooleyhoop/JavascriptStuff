module GUI
	class HooView

		attr_accessor :width
		attr_accessor :height
		attr_accessor :views

		def initialize
			@views = Array.new;
		end

		def addSubView( aView )
			@views << aView;
		end

		#woah! model.model_name.partial_path
		def self.model_name
			return self;
		end

		def self.partial_path
			#NB if we didnt want the GUI/ prefix we could do  name.split('::').last || ''
			return self.name.underscore;
		end
					
    def debugFixture

		end
			
	end
end

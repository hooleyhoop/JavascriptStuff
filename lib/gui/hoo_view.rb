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


	end
end

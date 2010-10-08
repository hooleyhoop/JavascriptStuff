module GUI
	class HooWindow

			attr_accessor :name
			attr_accessor :views

			def initialize
				@name = "thierry"
				@views = Array.new;
			end

			def addSubView( aView )
				@views << aView;
			end

			def drawNow( controller )
				controller.instance_variable_set(:@window, self);
				controller.render :action =>"contentview", :layout=>'hoowindow'
			end

	end
end

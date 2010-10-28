module GUI
	class HooWindow

			attr_accessor :name
      attr_accessor :startupScripts
      attr_accessor :contentView;
      
			def initialize
				@name = "thierry"
				@startupScripts = Array.new();
				@contentView = HooView.new();
				@contentView.parentView = self;
			end

			def drawNow( controller )
				controller.instance_variable_set(:@window, self);
				controller.render :template =>"/pages/content_view", :layout=>'window'
			end

      def installStartupJavascript( args )
        @startupScripts.push( args )
      end
    
      def parentView
        return nil;
      end
      
	end
end
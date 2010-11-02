module GUI
	class HooWindow

			attr_accessor :name;
			attr_accessor :headerComponents;
      attr_accessor :startupScripts;
      attr_accessor :contentView;

			def initialize
				@name = "thierry";
				@startupScripts = nil;
				@headerComponents = nil
								
				@contentView = HooView.new();
				@contentView.parentView = self;
				@displaySettings = {
				  :template =>"/gui/content_view", 
				  :layout=>'window'
			  }				
			end

      def addheaderComponent( arg )
        @headerComponents ||=  Array.new();
        @headerComponents.push( arg );
      end
    
			def drawNow( controller )
				controller.instance_variable_set(:@window, self);
				controller.render( @displaySettings )
			end

      def installStartupJavascript( args )
        @startupScripts ||=  Array.new();        
        @startupScripts.push( args );
      end

      def parentView
        return nil;
      end
      
	end
end
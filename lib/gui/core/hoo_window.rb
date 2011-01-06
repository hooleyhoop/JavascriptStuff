module GUI::Core
	class HooWindow

		attr_accessor :name;
		attr_accessor :headerComponents;
		attr_accessor :startupScripts;
		attr_accessor :contentView;
		attr_accessor :style;
		attr_accessor :controller;

		def initialize
			@name = 'thierry';
			@style = 'grad_background'
			@startupScripts = nil;
			@headerComponents = nil

			@contentView = HooView.new();
			@contentView.parentView = self;
			@displaySettings = {
				:template =>"/gui/core/content_view",
				:layout=>'../gui/core/window'
			}
		end

		def addheaderComponent( arg )
			@headerComponents ||=  Array.new();
			@headerComponents.push( arg );
		end

		def drawNow( controller )

            @controller = controller

			#-- assert if rails 3
			#-- NB, if rails 2 we handled this in HooPresenter. Sort this shit out
	    	if( Rails::VERSION::MAJOR > 2 )
    			controller.instance_variable_set(:@window, self);
            end

			controller.render( @displaySettings )
		end

		def installStartupJavascript( args )
			@startupScripts ||=  Array.new();
			@startupScripts.push( args );
		end

		def parentView
			return nil;
		end

        def showGrid
            @style = 'showgrid'
        end

	end
end

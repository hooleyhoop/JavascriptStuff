module GUI::Core
	class HooView < Object

		attr_accessor :parentView
		attr_accessor :views
		attr_accessor :width, :height

        @@_doOnceStuff = Array.new;

		def self.partial_path
			#NB if we didnt want the GUI/ prefix we could do  name.split('::').last || ''
			return self.name.underscore;
		end

		#woah! model.model_name.partial_path
		def self.model_name
			return self;
		end

		def initialize
			@views = Array.new;
		end

        # er, this is sometimes overidden
		def addSubView( aView )
		    _addSubView( aView );
        end

		def _addSubView( aView )
			@views << aView;
			if( aView.parentView!=nil )
			  raise "View allready has parentView"
			end
			aView.parentView = self;
			aView.wasAddedToParentView();
		end

        def setSubviewAtIndex( ind, subview )
            @views[ind] = subview
        end

		def setupDebugFixture
		end

		def id
		  self.object_id
		end

		# gui_hoo_text_list_view_2168956940
		def uniqueSelector
			className = self.class.to_s
			className = className.gsub('::','_')
			textListSelector = '#' + className.underscore + '_'+ self.object_id.to_s
		end

		def varName
			className = self.class.to_s
			className = className.gsub('::','_')
			textListSelector = '_' + className.underscore + '_'+ self.object_id.to_s
		end

		def window
			window = self
			while window.parentView !=nil
				window = window.parentView
			end
			return window;
		end

		def wasAddedToParentView
		end

		# this can be used instead of a haml file
		def stringOutput
		end

        def includeOnce?
            className = self.class
            #puts className.to_s
            if( @@_doOnceStuff.index( className )!=nil )
                return false;
            elsif
                @@_doOnceStuff << className
                return true;
            end
        end
	end
end

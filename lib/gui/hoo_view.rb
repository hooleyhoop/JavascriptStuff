module GUI
	class HooView < Object

    attr_accessor :parentView
    attr_accessor :views
		
		attr_accessor :width
		attr_accessor :height

		def initialize
			@views = Array.new;
		end

		def addSubView( aView )
			@views << aView;
			if( aView.parentView!=nil )
			  raise "View allready has parentView"
			end
			aView.parentView = self;
			aView.wasAddedToParentView();
		end

		#woah! model.model_name.partial_path
		def self.model_name
			return self;
		end

		def self.partial_path
			#NB if we didnt want the GUI/ prefix we could do  name.split('::').last || ''
			return self.name.underscore;
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
	  
		def window
		  window = self
		  while window.parentView !=nil
		    window = window.parentView
	    end
	    return window;
	  end
	  
	  def wasAddedToParentView
    end
    
    def stringOutput
    end
    
	end
end

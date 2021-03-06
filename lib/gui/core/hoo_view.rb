module Gui::Core

	class HooView < Object

		require 'gui/hoo_widget_list'

		attr_accessor :parentView
		attr_accessor :views

        @@_doOnceStuff = Array.new;

		# overide this if you want a cool name, like.. snakeForce
		def self.dslName
			dslName = name.demodulize
		end

		def self.partial_path
			#NB if we didnt want the GUI/ prefix we could do  name.split('::').last || ''
			return self.name.underscore;
		end

		#woah! model.model_name.partial_path
		def self.model_name
			return self;
		end

		def initialize( args={} )
			@views = Array.new;
		end

		def extractArgs( argHash, defaultValues )

    		defaultValues.each do |key, value|

				passedArg = argHash[key]
		  		if passedArg.nil?
		  			passedArg = value
		  		else
					#-- what is type of defaulty value
					#-- cooerce to that type
					if value =~ /^[-+]?[0-9]+$/
					#if value.kind_of? Integer
						puts "Converting #{passedArg} to #{passedArg.to_i}"
						passedArg = passedArg.to_i
					end
		  		end

      			setterMethodName = "#{key}="
				if( respond_to?( setterMethodName ) )
					self.send( setterMethodName, passedArg );
				else
					instanceVarName = "@#{key}"
					instance_variable_set( instanceVarName, passedArg );
				end
			end
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

		# 2168956940
		def id
		  self.object_id
		end

		# _gui_hoo_text_list_view_2168956940
		def uniqueSelector
			self.varName
		end

		# _gui_hoo_text_list_view_2168956940
		def varName
			'_' + self.unQualifiedJsClassName.underscore + '_'+ self.object_id.to_s
		end

		# GUI_Views_Debug_FlippyToggleThing
		def unQualifiedJsClassName
			className = self.class.to_s
			className = className.gsub('::','_')
		end

		# This is OKorrect
		# ABoo.GUI_Views_Debug_FlippyToggleThing
		def qualifiedJsClassName
			'ABoo.'+self.unQualifiedJsClassName
		end

		# gui_views_debug_flippy_toggle_thing
		def CSSClassName
			self.unQualifiedJsClassName.underscore
		end

		def HTMLIDName
			self.CSSClassName + '_'+ self.object_id.to_s
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

    protected

		# This sucks. Namespaces suck. Does ruby have macros?
		def widgetClass(*args)
			Gui::HooWidgetList.widgetClass(*args)
		end

	end
end

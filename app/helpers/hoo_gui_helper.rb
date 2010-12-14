module HooGuiHelper

	# add object to the viewstack
	def push( obj )

		if( obj==nil )
		  raise "cant push nil onto the view stack"
    end

		viewStack = self.instance_variable_get("@hooViews");
		if(viewStack==nil)
			viewStack = Array.new();
			self.instance_variable_set( "@hooViews", viewStack );
		end
		viewStack << obj;
	end

	# remove object from the viewstack
	def pop()

		viewStack = self.instance_variable_get("@hooViews");
		if( viewStack==nil || viewStack.size()==0 )
			raise "unpalanced view stack"
		end
		viewStack.pop();
	end


	# Shortcut for top object on the viewstack
	def _
		viewStack = self.instance_variable_get("@hooViews");
		return viewStack.last;
	end


	# Conditionally render the object
	# If we do render it, make sure we pop it off the view stack afterwards
	def insert( obj, placeHolderString )

		returnOb = nil;
		if(obj!=nil)
			#collectionSize = 1;
			#if(obj.respond_to?('size'))
			#	collectionSize = obj.size();
			#	puts "SIZE IS " + (collectionSize.to_s) +" "+(obj.class.to_s)+" "+(obj.respond_to?(:to_ary).to_s)
			#end

			returnOb = subRender(obj)
			#obj.each do |view|
      #	returnOb = returnOb + subRender(view)
    	#end

			# repeat for each object
			#collectionSize.times{ pop() };

		else
			 returnOb = "ERROR: "+placeHolderString
		end

		return returnOb;
 	end

	#
	def _renderSingleView( view )
		output = view.stringOutput
		if(output==nil)
	    	output = render view;
	    	pop()
		end
		output
	end

  # will render a view or array of views
	def subRender( views )

	  segments = ""

	  if( views.is_a? Array ) # views.method_defined? :each
      views.each do |view|
        segments << _renderSingleView(view);
	    end
    else
      segments = _renderSingleView( views );
	  end

    return segments.html_safe;
  end



	#
	#
	#
	#
  #
	# not part of the view hack
	def runStartupScripts

	  result = ""
	  if( @window.startupScripts )
  	  @window.startupScripts.each do |script|
  	    # arguments must be strings t the moment
  	    # for each script rebuild the function call "function('arg1','arg2');function('arg1');function('arg1','arg2','arg3')"
  	    result = result + script[:function]+"("
  	    1.upto(script.length-1) { |i|
  	      argName = ("arg"+i.to_s).to_sym
          result = result + "\'" + script[argName].to_s + "\'"
          if(i<script.length-1)
            result = result + ","
          end
        }
  	    result = result + ");"
      end
    end
	  return result;
	end

	def insertHeaderAdditions
	  result = ""
	  if( @window.headerComponents )
	    @window.headerComponents.each do |headerElement|
	      result = result + headerElement
      end
	  end
	  return result;
  end

end
module PagesHelper


	def eatShit( obj )
		#request = self.instance_variable_get("@_request")
		#locals = request.instance_variable_get("@locals")
		#locals.inspect
		#self.inspect
		#@locals[1];
	end

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
			collectionSize = 1;
			if(obj.respond_to?('size'))
				collectionSize = obj.size();
			end
			returnOb = subRender(obj)
			
			# repeat for each object
			collectionSize.times{ pop() };
			
		else
			 returnOb = "ERROR: "+placeHolderString
		end

		return returnOb;
 	end
	
	
	
	#
	#
	#
	#
  #
	# not part of the view hack
	def runStartupScripts

	  result = ""
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
	  return result;
	end
	
	
	def subRender( view )
	
	  output = view.stringOutput
	  if(output==nil)
	    return render view;
    end
    return output;
  end
  
end

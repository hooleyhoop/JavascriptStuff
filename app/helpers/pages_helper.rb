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
			returnOb = render(obj)
			
			# repeat for each object
			collectionSize.times{ pop() };
			
		else
			 returnOb = "ERROR: "+placeHolderString
		end

		return returnOb;
 	end
	
end

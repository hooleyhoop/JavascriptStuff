module HooGuiHelper

	# add object to the viewstack
	def push( obj )

		if obj.nil?
		  raise "cant push nil onto the view stack"
		end

		viewStack = self.instance_variable_get("@hooViews");
		if viewStack.nil?
			viewStack = Array.new()
			self.instance_variable_set( "@hooViews", viewStack )
		end
		viewStack << obj
	end

	# remove object from the viewstack
	def pop()

		viewStack = self.instance_variable_get("@hooViews");
		if viewStack.nil? or viewStack.empty?
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

		# Try string output first
		output = view.stringOutput
		if output.nil?
			#push( hoo_blue_view )
			#puts view.class.to_s.demodulize.underscore;
			# testing if we need to do this in the haml or not!
			push(view)
	    	output = render view
	    	pop()
		end

		# Does this view want any json injecting into the page?
		if view.class.method_defined? :jsonProperties

			jsonProps = view.jsonProperties();
			unless (jsonProps.nil? or jsonProps.empty?)
				jsonProps = jsonProps.to_json();
				instanceName = view.varName+'_json'

				#j = ActiveSupport::JSON
				data = instanceName+' = '+jsonProps+';';
				#puts "GOT JSON! "+data

				@window.pushJSONString( data );
			else
				puts "NOT GOT NO JSON! "+ view.varName
			end
		end
		return output
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

	#
	#
	#
	def insertHeaderAdditions()
	  result = ""
	  if( @window.headerComponents )
		@window.headerComponents.each do |headerElement|
		  result = result + headerElement
		end
	  end
	  return result;
	end

	#
	#
	#
	def insertJSONData()

		result = ""
		if( @window.jSONContent )
			@window.jSONContent.each do |jsonElement|
			  result = result + jsonElement
			end
		end

		tt = <<END
<script type="text/javascript">
	//<![CDATA[
		#{result};
 	//]]>
</script>
END
		return  tt.html_safe()
	end

	# autoName the data-jsClass
	def wrapLiveObject( obj, attrs={} )
		# NB! haml_tag writes directly to the haml buffer, we dont return this then insert it in the page
		stdAttrs = {:class=>_.CSSClassName, :id=>_.HTMLIDName, :data=>{'jsclass'=>_.qualifiedJsClassName}}
		stdAttrs.merge!(attrs)
		haml_tag :div, stdAttrs do
		  	yield
		end
	end

	# i am not sure if these stags should be self closed or not (param tags are wierd? Not sure i can do with haml)
	def embedSwf( swfURL, idNum, widthStr, heiStr, colStr, attrs=nil )
		haml_tag :object, { :data=>swfURL, :id=>idNum, :type=>'application/x-shockwave-flash', :width=>widthStr, :height=>heiStr } do

			stdAttrs = {:rootID=>idNum}
			stdAttrs.merge!(attrs)
			attrsAsString = stdAttrs.collect { |k, v| "#{k}=#{v}" }.join('&')

			haml_tag :param, { :name=>'movie', :value=>swfURL }
			haml_tag :param, { :name=>"scale", :value=>"noscale" }
			haml_tag :param, { :name=>"salign", :value=>"lt" }
			haml_tag :param, { :name=>"bgColor", :value=>colStr }
			haml_tag :param, { :name=>'allowScriptAccess', :value=>'always' }
			haml_tag :param, { :name=>"wmode", :value=>"window" }
			haml_tag :param, { :name=>'FlashVars', :value=>attrsAsString }
		end
	end


end


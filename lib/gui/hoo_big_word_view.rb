module GUI
	class HooBigWordView < HooView

		def initialize( inputString )
			super();
			@text = inputString
		end

    def stringOutput

      return "<div class='bigType'>"+@text+"</div>".html_safe
      
      haml_string = 
      "%div 
        trumpety trump"
        
      engine = Haml::Engine.new(haml_string)
      hamlResult = engine.render
      puts hamlResult.class
      
      return hamlResult
    end
    
	end
end

module GUI
	class HooBigWordView < HooView

		def initialize( inputString )
			super();
		end

    def stringOutput

      return "<div>trumpety trump</div>".html_safe
      
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

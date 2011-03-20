module GUI::Views
	class HooBigWordView < GUI::Core::HooView

		attr_accessor :text;

		def initialize( inputString="empty" )
			super();
			@text = inputString
		end

		# HooBigWordView doesn't use a haml file, it just outputs this string
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

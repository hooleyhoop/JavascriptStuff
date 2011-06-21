module GUI::Views::Debug::Basic

	# http://0.0.0.0:3000/widgets/bigWord?text=hello_world
	class HooBigWordView < GUI::Core::HooView

		attr_accessor :text;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:text=>"empty"} );
		end

		# HooBigWordView doesn't use a haml file, it just outputs this string
		def stringOutput

			return "<div class='bigType'>"+@text+"</div>".html_safe

			haml_string =
			"%div
			trumpety trump"

			# should use haml_tag, capture_haml, haml_concat .. etc.?
			engine = Haml::Engine.new(haml_string)
			hamlResult = engine.render
			puts hamlResult.class

			return hamlResult
		end

	end
end

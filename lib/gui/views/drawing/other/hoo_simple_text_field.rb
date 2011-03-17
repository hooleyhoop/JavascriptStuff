module GUI::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/simpleTextField
	# http://0.0.0.0:3000/widgets/simpleTextField?prefix=Hello&text=World&postfix=Humpf
	class HooSimpleTextField < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :prefix, :text, :postfix
		attr_accessor :bindings

		def initialize( args={} )
			super(args);

			# This must be automaticalable?
			if args[:prefix]
				@prefix=args[:prefix];
			end
			if args[:text]
				@text=args[:text];
			end
			if args[:postfix]
				@postfix=args[:postfix];
			end

		end

		def fullString
			prefix+text+postfix
		end

        # Mock Data
		def setupDebugFixture
			@prefix = 'Duration: ' unless @prefix;
			@text = '13' unless @text;
			@postfix = ' seconds' unless @postfix;
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:prefix				=> @prefix,
				:text				=> @text,
				:postfix			=> @postfix,
			}
			allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
			return allItems.to_json();
		end

		def addBinding( aHash )
			if(@bindings==nil)
				@bindings = {};
			end
			@bindings.merge!( aHash );
		end

	end
end

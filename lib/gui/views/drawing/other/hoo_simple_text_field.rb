module Gui::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/HooSimpleTextField
	# http://0.0.0.0:3000/widgets/HooSimpleTextField?prefix=Hello&text=World&postfix=Humpf
	class HooSimpleTextField < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin
		include Test::Unit::Assertions

		attr_accessor :prefix, :text, :postfix

		def initialize( args={} )
			super(args);
			extractArgs( args, {:prefix=>'Duration: ', :text=>'13', :postfix=>' seconds'} );
		end

		def fullString
			prefix+text+postfix
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
				:prefix				=> @prefix,
				:text				=> @text,
				:postfix			=> @postfix,
			}
			# allItems.merge!( { :bindings => @bindings } ) unless @bindings==nil;
		end


	end
end

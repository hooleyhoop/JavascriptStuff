module GUI::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/simpleCheckbox
	class HooSimpleCheckbox < GUI::Core::HooView

		include GUI::Core::HooBindingsMixin
		include Test::Unit::Assertions

		attr_accessor :label;

		def initialize( args={} )
			super(args);
			extractArgs( args, {:label=>'unNamed'} );
		end

        # Mock Data
		def setupDebugFixture
			super();
			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooAlert', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
			}
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;

			return allItems.to_json();
		end

	end
end

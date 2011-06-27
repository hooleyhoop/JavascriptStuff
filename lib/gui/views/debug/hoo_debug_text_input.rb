module Gui::Views::Debug

	# http://0.0.0.0:3000/widgets/HooDebugTextInput?label=gonk&value=mightmouse
	class HooDebugTextInput < Gui::Core::HooView

		include Gui::Core::HooBindingsMixin

		attr_accessor :label
		attr_accessor :value

		def initialize( args={} )
			super(args);
			extractArgs( args, {:label=>'unNamed', :value=>'hello world'} );
		end

		# Mock data
		def setupDebugFixture
			super();
			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooAlert', :action_arg=>nil, :actionIsAsync=>false  }} );
		end

		def jsonProperties
			allItems = {}
			allItems.merge!( { :javascriptActions => @javascriptActions } ) unless @javascriptActions==nil;
		end

	end
end

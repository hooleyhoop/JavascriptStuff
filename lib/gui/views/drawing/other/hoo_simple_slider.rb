module GUI::Views::Drawing::Other

	# http://0.0.0.0:3000/widgets/simpleSlider
	class HooSimpleSlider < GUI::Core::HooView

		include Test::Unit::Assertions

		def initialize( args={} )
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

			#-- add a checkbox
			chckBox = GUI::HooWidgetList.widgetClass('simpleCheckbox').new( {:label=>'show busy'} )
			chckBox.addJavascriptAction( { :mouseClick=>{ :action_taget=>self.varName, :action_event=>'toggleBusy', :action_arg=>'Holy Cock' }} );
			self.addSubView( chckBox );
		end

		# stuff to write into the page
		def jsonProperties
			allItems = {
			}
			return allItems.to_json();
		end

	end
end

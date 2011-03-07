module GUI::Views::Drawing::Buttons

	# 2 state button
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/largeSinglebuttonForm
	class HooLargeSingleButtonForm < GUI::Core::HooView

		attr_accessor :img;
		attr_accessor :width, :height;
		attr_accessor :label, :labelColor;
		attr_accessor :action;

		def initialize( args={} )
			super();
		end

        # Mock Data
		def setupDebugFixture
			super();
			@img = '../images/buttons/edit-button.png';
			@width = 105;
			@height = 45;
			@label = 'hello'
			@labelColor = '#969696'
			@action = ''
		end

		def jsonProperties
			allItems = {
				:img	=> @img,
				:width	=> @width
			}
			return allItems.to_json();
		end

	end
end


# Have to run when loaded by ajax
# self.window.installStartupJavascript( :function=>"crippleListView", :arg1=>@textList.uniqueSelector(), :arg2=>@widgetResizer.actionName );

module Gui::Views::Drawing::Buttons::FormButton

	# 3 state Simple button
	# 0) Disabled 1)state1 2)state1Pressed
    # Height is just the height of one state

	# http://0.0.0.0:3000/widgets/formButtonSimple
	# http://0.0.0.0:3000/widgets/formButtonSimple?initialState=1

	class HooFormButtonSimple < HooFormButtonAbstract

		def initialize( args={} )
			@_states = 3
			super(args);
		end

        # Mock Data
		def setupDebugFixture
			super();

			@labelStates = ['Disabled', 'Ready', 'Pressed'];
			@img = '../images/buttons/simple-button/3-state-combine.png';
			@size = [105, 45];
			@initialState=0 if @initialState==nil
			@labelColor = '#eee';
			#@action = '/widgets/_ajaxPostTest';
			@action = 'http://apple.com';
			self.addJavascriptAction( { :mouseClickAction=>{ :action_taget=>'HooWindow', :action_event=>'hooLog', :action_arg=>'Holy Cock', :actionIsAsync=>false  }} );

		end

	end
end

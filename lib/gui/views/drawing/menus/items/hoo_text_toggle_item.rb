module GUI::Views::Drawing::Menus::Items

	# http://0.0.0.0:3000/widgets/textToggleItem?initialState=1
	class HooTextToggleItem < GUI::Core::HooView

		include Test::Unit::Assertions

		attr_accessor :url;
		attr_accessor :labelStates;
		attr_accessor :initialState;
		attr_accessor :action

		def initialize( args={} )
			super();
			if args[:initialState]
				@initialState=args[:initialState].to_i();
			end
		end

        # Mock Data
		def setupDebugFixture
			super();
			@initialState=1 if @initialState==nil

			@labelStates = ['Disabled', 'Follow', 'Down1', 'Unfollow', 'Down2'];
			@action = '/widgets/_ajaxPostTest';
		end


	end
end

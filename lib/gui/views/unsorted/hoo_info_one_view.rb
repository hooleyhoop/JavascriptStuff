module GUI::Views
	class HooInfoOneView < GUI::Core::HooView

    attr_accessor :title, :text;

		def initialize
			super();
		end

    def setupDebugFixture
      super();
      @title = "Police terror training increased";
			@text = "UK security chiefs have ordered an acceleration in police training to prepare for any future Mumbai-style gun attacks in public places.";
    end

	end
end

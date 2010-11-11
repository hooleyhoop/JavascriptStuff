module GUI::Views
	class HooPullQuoteOneView < GUI::Core::HooView

    attr_accessor :text;

		def initialize
			super();
		end

    def setupDebugFixture
      super();
			@text = "The active dose of BPA has been furiously contested in what has become an intense scientific dispute";
    end

	end
end

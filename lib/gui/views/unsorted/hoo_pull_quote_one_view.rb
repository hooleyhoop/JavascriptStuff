module GUI::Views::Unsorted

	# http://0.0.0.0:3000/widgets/pullQuote1
	class HooPullQuoteOneView < GUI::Core::HooView

    attr_accessor :text;

    def setupDebugFixture
      super();
			@text = "The active dose of BPA has been furiously contested in what has become an intense scientific dispute";
    end

	end
end
